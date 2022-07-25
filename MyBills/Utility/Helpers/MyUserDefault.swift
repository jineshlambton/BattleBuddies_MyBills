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
    
    func setLoggedInUser(user : User) {
        userDefault.set(user.uid, forKey: Constant.UserDefaultKey.loggedInUser)
    }
    
    func getLoggedInUser() -> String? {
        if userDefault.object(forKey: Constant.UserDefaultKey.loggedInUser) != nil {
            return userDefault.object(forKey: Constant.UserDefaultKey.loggedInUser) as! String
        } else {
            return nil
        }
    }
}
