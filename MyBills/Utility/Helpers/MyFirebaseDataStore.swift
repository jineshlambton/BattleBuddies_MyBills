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
    @objc optional func categoryAddedSuccessfully()
    @objc optional func categorySynced()
    @objc optional func deletedCategorySuccessfully()
    @objc optional func updatedCategorySuccessfully()
}

class MyFirebaseDataStore : NSObject {
    private let db = Firestore.firestore()
    
    static var instace = MyFirebaseDataStore()
    
    weak var delegate : MyFirebaseDataStoreDelegate?
    var arrCategory = [MyItemsCategory]()
    
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
    
    func addCategory(category : MyFirebaseCategory) {
        var ref : DocumentReference? = nil
        print("dic : \(category.dict)")
        ref = db.collection("Category").addDocument(data: category.dict, completion: { [self] error in
            if let err = error {
                print("Error adding category : \(err)")
            } else {
                delegate?.categoryAddedSuccessfully?()
                print("Category added : Ref id : \(String(describing: ref?.documentID))")
            }
        })
    }
    
    func getCategories() {
        db.collection("Category").getDocuments(completion: { [self] query, error in
            if let err = error {
                print("Error adding category : \(err)")
            } else {
                arrCategory.removeAll()
                for doc in query!.documents {
                    var objCate = MyItemsCategory()
                    objCate.documentID = doc.documentID
                    objCate.uid = doc.data()["uid"] as? String
                    objCate.name = doc.data()["name"] as? String
                    arrCategory.append(objCate)
                }
                delegate?.categorySynced?()
            }
        })
    }
    
    func deleteCategory(id : String) {
        db.collection("Category").document(id).delete { [self] error in
            if let err = error {
                print("Error removing document: \(err)")
            } else {
                delegate?.deletedCategorySuccessfully?()
                print("Document successfully removed!")
            }
        }
    }
    
    func updateCategory(category : MyItemsCategory) {
        db.collection("Category").document(category.documentID!).setData(["name" : category.name!],merge: true)
        delegate?.updatedCategorySuccessfully?()
    }
}

class MyFirebaseCategory : JSONSerializable {
    var name : String?
    var uId : String?
    
    var dict : [String : Any] { return ["name": self.name ?? "", "uid": self.uId ?? ""] }
}

class MyItemsCategory  {
    var documentID : String?
    var name : String?
    var uid : String?
}
