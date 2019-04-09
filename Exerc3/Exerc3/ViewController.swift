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
        case emptyText(birth_Year)
        case invalidFormat
        case invalidDate
        case futureBirthday
        case unknown
        
    }
    
    @IBOutlet weak var birth_Year: UITextField!
    @IBOutlet weak var calc: UIButton!
    @IBOutlet weak var age: UILabel!
    
    @IBAction func onclick(_ sender: Any) {
        
    }
    private func calculateAge(from text:String,dateFormat: String) throws -> Int{
        let now = Date()
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

