//
//  MyButton.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import Foundation
import UIKit

@IBDesignable

class MyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup() {
        self.layer.masksToBounds = true
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = MyColor.btnBackground.color
        self.layer.cornerRadius = self.frame.height / 2
        DispatchQueue.main.async {
            self.titleLabel?.font = UIFont.BTN_NORAML
            self.setNeedsDisplay()
        }
    }
}
