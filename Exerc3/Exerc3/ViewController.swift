//
//  ViewController.swift
//  Exerc3
//
//  Created by user151701 on 3/26/19.
//  Copyright © 2019 user151701. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum AgeError: Error{
        case emptyText
        case invalidFormat
        case invalidDate
        case futureBirthday
        case unknown
        
    }
    
    @IBOutlet weak var birth_Year: UITextField!
    @IBOutlet weak var calc: UIButton!
    @IBOutlet weak var age: UILabel!
    
    @IBAction func onclick(_ sender: Any) {
        do{
            let age = try calculateAge(from: birth_Year.text ?? "", dateFormat: "dd/MM/yyyy")
            age.text = String(age)     + " anos"
            age.text = ""
        } catch AgeError.emptyText {
            birthdateTextErrorField.text = "Data não informada!"
            birthdateTextField.text = "00"
        } catch AgeError.futureBirthday {
            birthdateTextErrorField.text = "Prevendo o futuro?"
            birthdateTextField.text = "00"
        } catch AgeError.invalidDate {
            birthdateTextErrorField.text = "Data inválida!"
            birthdateTextField.text = "00"
        } catch AgeError.invalidFormat {
            birthdateTextErrorField.text = "Formato inválido!"
            birthdateTextField.text = "00"
        } catch AgeError.unknown {
            birthdateTextErrorField.text = "Erro desconhecido!"
            birthdateTextField.text = "00"
        } catch {
            birthdateTextErrorField.text = "Erro inesperado!"
            birthdateTextField.text = "00"
        }
        
    }
    private func calculateAge(from text:String?,dateFormat: String) throws -> Int{
        
        if text == nil {
            throw AgeError.emptyText
        }
        else{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YYYY"
            
            if let birth_Year = dateFormatter.date(from: text!) {
                
                let now = Date()
                guard birth_Year <= now else { throw AgeError.futureBirthday }
                
                if let age = Calendar.current.dateComponents([.year], from: birth_Year, to: now ).year {
                    return age
                } else {
                    throw AgeError.invalidDate
                }
                
            } else{
                throw AgeError.invalidFormat
            }
            
        }
        
        throw AgeError.unknown
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

