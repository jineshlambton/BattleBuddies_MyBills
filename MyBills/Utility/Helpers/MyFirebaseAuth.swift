//
//  MyFirebase.swift
//  MyBills
//
//  Created by Vraj Patel on 24/07/22.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseCore

@objc protocol MyFirebaseDelegate : NSObjectProtocol {
    @objc optional func isAuthenticatedUser(user : User)
    @objc optional func inValidUserDetails()
    @objc optional func userNotFound()
    @objc optional func userExist()
    @objc optional func userCreatedSuccessfully(user : User)
}

final class MyFirebaseAuth : NSObject {
    
    static var instace = MyFirebaseAuth()
    
    weak var delegate : MyFirebaseDelegate?
    
    private override init() {
    }
    
    func login(user : MyFirebaseUser) {
        let email = user.emailAddress ?? ""
        let password = user.password ?? ""
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if error != nil {
                if let strErr = error?.localizedDescription  {
                    if strErr == "The password is invalid or the user does not have a password." {
                        delegate?.inValidUserDetails?()
                    } else if strErr == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        delegate?.userNotFound?()
                    }
                }
            }
            if result != nil {
                if let res = result  {
                    delegate?.isAuthenticatedUser?(user: res.user)
                }
            }
        }
    }
    
    func createUser(user : MyFirebaseUser) {
        let email = user.emailAddress ?? ""
        let password = user.password ?? ""
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in
            if error != nil {
                print("Error in create user on authentication: \(error)")
                if let strErr = error?.localizedDescription {
                    if strErr == "The email address is already in use by another account." {
                        delegate?.userExist?()
                    }
                }
            }
            if result != nil {
                if let res = result  {
                    delegate?.userCreatedSuccessfully?(user: res.user)
                }
            }
        }
    }
}

class MyFirebaseUser : JSONSerializable {
    
    var emailAddress : String?
    var password : String?
    var firstName : String?
    var lastName : String?
    var uID : String?
    
    var dict : [String : Any] { return ["emailAddress": self.emailAddress ?? "", "firstName": self.firstName ?? "", "lastName" : self.lastName ?? "", "uid" : self.uID ?? ""] }
    
}
