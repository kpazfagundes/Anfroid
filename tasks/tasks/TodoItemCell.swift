//
//  TodoItemCell.swift
//  tasks
//
//  Created by user151701 on 4/2/19.
//  Copyright © 2019 user151701. All rights reserved.
//

import UIKit

class TodoItemCell: UITableViewCell{
    var isCompleted = false {
        didSet{
            guard let currentText = textLabel?.text else{ return}
        
        let strikeStyle = isCompleted
            ? NSNumber(value: NSUnderlineStyle.single.rawValue)
            :NSNumber(value: 0)
        let strokeEffect:[NSAttributedString.Key : Any] = [.strikethroughStyle: strikeStyle,
                                                           .strikethroughColor: UIColor.black]
        
        textLabel?.attributedText = NSAttributedString(string: currentText, attributes: strokeEffect)
        }
    }
}

