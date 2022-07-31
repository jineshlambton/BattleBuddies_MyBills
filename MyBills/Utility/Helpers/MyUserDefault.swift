//
//  MyUserDefault.swift
//  MyBills
//
//  Created by Vraj Patel on 24/07/22.
//

import Foundation
import Firebase

final class MyUserDefault : NSObject {
    
    static var instace = MyUserDefault()
    
    private override init() {
    }
    
    private let userDefault = UserDefaults.standard
    
    func setLoggedInUser(user : User? = nil) {
        if let objUser = user {
            userDefault.set(objUser.uid, forKey: Constant.UserDefaultKey.loggedInUser)
            userDefault.synchronize()
        } else {
            userDefault.set(nil, forKey: Constant.UserDefaultKey.loggedInUser)
            userDefault.synchronize()
        }
    }
    
    func getLoggedInUser() -> String? {
        if userDefault.object(forKey: Constant.UserDefaultKey.loggedInUser) != nil {
            return userDefault.object(forKey: Constant.UserDefaultKey.loggedInUser) as! String
        } else {
            return nil
        }
    }
}
