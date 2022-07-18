//
//  MyDate.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import Foundation
import UIKit

extension Date {
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
