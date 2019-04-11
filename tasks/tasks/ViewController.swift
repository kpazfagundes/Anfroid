//
//  ViewController.swift
//  tasks
//
//  Created by user151701 on 4/2/19.
//  Copyright © 2019 user151701. All rights reserved.
//

import UIKit
struct Todo:Codable{
    var task: String
    var isCompleted: Bool = false
    var id: Int?
    init (task: String){
        self.task = task
        self.isCompleted = false
        
    }
    
}
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Todo] = []
    //      Todo(task: "Terminar ecercicio de IOS"),
    //     Todo(task: "Trocar Android por um Ifone"),
    //      Todo(task: "Comprar um Macbook"),
    //  ]
    
    @IBAction func addTask(_ sender: Any) {
        let alertController = UIAlertController(title: "Nova Tarefa", message: "Digite a nova tarefa", preferredStyle: .alert)
        alertController.addTextField{
            (textField) in textField.placeholder = "Tarefa"
            
        }
        let okAction = UIAlertAction(title: "ok", style: .default, handler: { _ in guard let newtask = alertController.textFields?.first?.text else { return}
            self.todoRepository.create(taskTitle: newtask) { (result) in
                switch result {
                case .success(let todo):
                    self.items.append(todo)
                    self.tableView.reloadData()
                case .error:
                    print("Error to create task!")
                }
            }
        })
        let cancelAction = UIAlertAction( title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    }
    
    func loadTodoItems(callback: @escaping () -> Void) {
        todoRepository.all { (result) in
            switch result {
            case .success(let todos):
                self.items = todos
            case .error:
                print("Error to get data!")
            }
            callback()
        }
    }
    private let todoRepository = TodoRepository(
        network: NetworkService(baseUrl: "https://puc-dam-todolist.herokuapp.com/"),
        token: "mPxOBiWWodNCe9tnrr3iVtONeL8lgi3mqKhd5QKK1WI=")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(TodoItemCell.self, forCellReuseIdentifier: "todoItem")
        tableView.dataSource = self
        tableView.delegate = self
        
        loadTodoItems() {
            self.tableView.reloadData()
        }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoItem", for: indexPath) as? TodoItemCell else { fatalError() }
        
        cell.textLabel?.text = items[indexPath.row].task
        cell.isCompleted = items[indexPath.row].isCompleted
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Seleção do item \(items[indexPath.row])")
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Remover", handler: {(action, view, completionHandler) in
            
            self.todoRepository.delete(id: self.items[indexPath.row].id ?? 0) { (result) in
                switch result {
                case.success:
                    self.items.remove(at: indexPath.row)
                    tableView.reloadData()
                    completionHandler(true)
                case .error:
                    print("Error to delete task")
                }
            }
        })
            
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completitionAction = UIContextualAction(style: .normal, title: "Concluído", handler: {(action, view, completionHandler) in
            self.todoRepository.toggleComplete(id: self.items[indexPath.row].id ?? 0) { (result) in
                switch result {
                case.success:
                    self.items[indexPath.row].isCompleted.toggle()
                    tableView.reloadData()
                    completionHandler(true)
                case .error:
                    print("Error to delete task")
                }
            }
            
        })
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [completitionAction])
        return swipeConfiguration
    }

}


