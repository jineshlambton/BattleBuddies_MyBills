//
//  MyTextfield.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import Foundation
import UIKit

@IBDesignable
open class MyTextField: UITextField {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.masksToBounds = true
        self.layer.borderColor = MyColor.textFieldBorder.color.cgColor
        self.layer.borderWidth = 1.0
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 10.0
        self.font = UIFont.TXT_TEXT
    }
    
    func setUpUsernameField() {
        self.keyboardType = .emailAddress
    }
    
    func setUpPasswordField() {
        self.isSecureTextEntry = true
    }
}
