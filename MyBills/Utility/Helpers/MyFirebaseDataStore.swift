//
//  MyFirebaseDataStore.swift
//  MyBills
//
//  Created by Vraj Patel on 24/07/22.
//

import Foundation
import Firebase
import FirebaseFirestore

@objc protocol MyFirebaseDataStoreDelegate : NSObjectProtocol {
    @objc optional func userAddedSuccessfully()
}

class MyFirebaseDataStore : NSObject {
    private let db = Firestore.firestore()
    
    static var instace = MyFirebaseDataStore()
    
    weak var delegate : MyFirebaseDataStoreDelegate?
    
    private override init() {
    }
    
    func addUser(user : MyFirebaseUser) {
        var ref : DocumentReference? = nil
        print("dic : \(user.dict)")
        ref = db.collection("Users").addDocument(data: user.dict, completion: { [self] error in
            if let err = error {
                print("Error adding document : \(err)")
            } else {
                delegate?.userAddedSuccessfully?()
                print("Data added : Ref id : \(String(describing: ref?.documentID))")
            }
        })
    }
}


protocol JSONSerializable {
    var dict: [String: Any] { get }
}

extension JSONSerializable {
    /// Converts a JSONSerializable conforming class to a JSON object.
    func json() throws -> Data {
        try JSONSerialization.data(withJSONObject: self.dict, options: .prettyPrinted)
    }
//    func json() rethrows -> Data {
//        try JSONSerialization.data(withJSONObject: self.dict, options: nil)
//    }
}
