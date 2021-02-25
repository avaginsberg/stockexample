//
//  CustomTextField.swift
//  Stockdo
//
//  Created by Dayton on 24/02/21.
//

import UIKit

class CustomTextfield: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
         if action == #selector(UIResponderStandardEditActions.paste(_:)) {
             return false
         }
         return super.canPerformAction(action, withSender: sender)
    }
    
    init(placeholder text: String) {
        super.init(frame: .zero)
        
        placeholder = text
        borderStyle = .none
        textColor = .black
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        autocapitalizationType = .none
        autocorrectionType = .no
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

