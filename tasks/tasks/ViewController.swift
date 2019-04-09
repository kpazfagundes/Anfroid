//
//  ViewController.swift
//  tasks
//
//  Created by user151701 on 4/2/19.
//  Copyright © 2019 user151701. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTask(_ sender: Any) {
        let alertController = UIAlertController(title: "Nova Tarefa", message: "Digite a nova tarefa", preferredStyle: .alert)
        alertController.addTextField{
            (textField) in textField.placeholder = "Tarefa"
            
        }
        let okAction = UIAlertAction(title: "ok", style: .default, handler: { _ in guard let newtask = alertController.textFields?.first?.text else { return}
            self.items.append(Todo(task: newtask))
        })
        let cancelAction = UIAlertAction( title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    }
    struct Todo{
        var task: String
        var isCompleted: Bool = false
        
        init (task: String){
            self.task = task
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(TodoItemCell.self,
                           forCellReuseIdentifier: "todoItem")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    var items: [Todo] = [
        Todo(task: "Terminar ecercicio de IOS"),
        Todo(task: "Trocar Android por um Ifone"),
        Todo(task: "Comprar um Macbook"),
    ]
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
        let removeAction = UIContextualAction(style: .destructive, title: "Remover", handler: {(action, view, completionHandler) in completionHandler(true)})
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeAction])
        return swipeConfiguration
    }

}


