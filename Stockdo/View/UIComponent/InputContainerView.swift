//
//  InputContainerView.swift
//  Stockdo
//
//  Created by Dayton on 25/02/21.
//

import UIKit

class InputContainerView:UIView {
    
    init(label:UILabel, textField:UITextField) {
        super.init(frame: .zero)
        
        setHeight(height: 40)
        
        addSubview(label)
        
        label.anchor(top: topAnchor,left: leftAnchor, paddingLeft: 8)
        label.setDimensions(height: 35 - 0.75, width: 160)
        
        
        addSubview(textField)
        textField.anchor(top: topAnchor,left: label.rightAnchor,
                         right: rightAnchor, paddingLeft: 8, height: 35)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        
        addSubview(dividerView)
        dividerView.anchor(left: leftAnchor, bottom: bottomAnchor,
                           right: rightAnchor, paddingLeft: 8, height: 0.75)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

