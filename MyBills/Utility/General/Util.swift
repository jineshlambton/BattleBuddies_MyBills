//
//  Util.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import Foundation
import Alamofire
import UIKit



class Util {
    
    static var appDelegate         = UIApplication.shared.delegate as! AppDelegate
    
    static let applicationName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    
    static func fromDate(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    static func isNetworkAvailable() -> Bool {
        if (NetworkReachabilityManager()?.isReachable)! {
            return true
        } else {
            return false
        }
    }
}

protocol JSONSerializable {
    var dict: [String: Any] { get }
}

extension JSONSerializable {
    func json() throws -> Data {
        try JSONSerialization.data(withJSONObject: self.dict, options: .prettyPrinted)
    }
}
