//
//  MyColor.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import Foundation
import UIKit

enum MyColor: String {
    case textFieldBorder
    case btnBackground
    case theme
    case cardView
    
    var color: UIColor {
        return UIColor(named: self.rawValue) ?? .clear
    }
}

extension UIColor {
    static func appColor(_ name: MyColor) -> UIColor? {
        let color = UIColor(named: name.rawValue)
         return color
    }
}
