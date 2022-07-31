//
//  MyFirebaseDataStore.swift
//  MyBills
//
//  Created by Vraj Patel on 24/07/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit

@objc protocol MyFirebaseDataStoreDelegate : NSObjectProtocol {
    @objc optional func userAddedSuccessfully()
    @objc optional func categoryAddedSuccessfully()
    @objc optional func itemAddedSuccessfully()
    @objc optional func categorySynced()
    @objc optional func itemsSynced()
    @objc optional func deletedCategorySuccessfully()
    @objc optional func updatedCategorySuccessfully()
    @objc optional func deletedItemSuccessfully()
    @objc optional func deletedItemFailed()
    @objc optional func itemUpdatedSuccessfully()
}

class MyFirebaseDataStore : NSObject {
    private let db = Firestore.firestore()
    
    static var instace = MyFirebaseDataStore()
    
    weak var delegate : MyFirebaseDataStoreDelegate?
    var arrCategory = [MyItemsCategory]()
    var arrItem = [MyItemsInformation]()
    
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
    
    func addItem(item : MyFirebaseItem) {
        var ref : DocumentReference? = nil
        print("dic : \(item.dict)")
        ref = db.collection("Items").addDocument(data: item.dict, completion: { [self] error in
            if let err = error {
                print("Error adding category : \(err)")
            } else {
                delegate?.itemAddedSuccessfully?()
                print("Item added : Ref id : \(String(describing: ref?.documentID))")
            }
        })
    }
    
    func updateItem(id : String, item : MyFirebaseItem) {
        db.collection("Items").document(id).setData(item.dict) { [self] error in
            if let err = error {
                print("Error adding category : \(err)")
            } else {
                delegate?.itemUpdatedSuccessfully?()
            }
        }
    }
    
    func getCategories() {
        db.collection("Category").getDocuments(completion: { [self] query, error in
            if let err = error {
                print("Error adding category : \(err)")
            } else {
                arrCategory.removeAll()
                for doc in query!.documents {
                    let objCate = MyItemsCategory()
                    objCate.documentID = doc.documentID
                    objCate.uid = doc.data()["uid"] as? String
                    objCate.name = doc.data()["name"] as? String
                    if objCate.uid == MyUserDefault.instace.getLoggedInUser() {
                        arrCategory.append(objCate)
                    }
                }
                delegate?.categorySynced?()
            }
        })
    }
    
    func getCategoryName(id : String) -> String {
        var strCategory = ""
        for i in 0 ..< arrCategory.count {
            if arrCategory[i].documentID == id {
                strCategory =  arrCategory[i].name ?? ""
                break
            }
        }
        return strCategory
    }
    
    func deleteItem(id : String) {
        db.collection("Items").document(id).delete { [self] error in
            if let err = error {
                print("Error removing document: \(err)")
                delegate?.deletedItemFailed?()
            } else {
                print("Item successfully removed!")
                delegate?.deletedItemSuccessfully?()
            }
        }
    }
    
    func getItems() {
        db.collection("Items").getDocuments(completion: { [self] query, error in
            if let err = error {
                print("Error fetching items : \(err)")
            } else {
                arrItem.removeAll()
                for doc in query!.documents {
                    let objItem = MyItemsInformation()
                    objItem.documentID = doc.documentID
                    objItem.uid = doc.data()["uid"] as? String
                    objItem.name = doc.data()["name"] as? String
                    objItem.categoryId = doc.data()["categoryId"] as? String
                    objItem.createDate = doc.data()["createDate"] as? Timestamp
                    objItem.description1 = doc.data()["description"] as? String
                    objItem.expiryDate = doc.data()["expiryDate"] as? Timestamp
                    objItem.imgBill = doc.data()["imgBill"] as? String
                    objItem.price = doc.data()["price"] as? String
                    objItem.purchaseDate = doc.data()["purchaseDate"] as? Timestamp
                    objItem.replacementDate = doc.data()["replacementDate"] as? Timestamp
                    if objItem.uid == MyUserDefault.instace.getLoggedInUser() {
                        arrItem.append(objItem)
                    }
                }
                sortItemArray()
                delegate?.itemsSynced?()
            }
        })
    }
    
    func isCategoryUsed(catId : String) -> Bool {
        var isFound = false
        for i in 0 ..< arrItem.count {
            var item = arrItem[i]
            if item.categoryId == catId {
                isFound = true
                break
            }
        }
        return isFound
    }
    
    private func sortItemArray() {
        let sortedArray = arrItem.sorted(by: {
            let date1 = Date(timeIntervalSince1970: Double($0.createDate!.seconds))
            let date2 = Date(timeIntervalSince1970: Double($1.createDate!.seconds))
            return date1 > date2
            
        })
        arrItem = sortedArray
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
    
    func minPriceValue() -> CGFloat {
        let minValue1 = MyFirebaseDataStore.instace.arrItem.min(by: { Int($0.price!)! < Int($1.price!)! })
        return CGFloat(Int(minValue1!.price!)!)
    }
    
    func maxPriceValue() -> CGFloat {
        let maxValue1 = MyFirebaseDataStore.instace.arrItem.max(by: { Int($0.price!)! < Int($1.price!)! })
        return CGFloat(Int(maxValue1!.price!)!)
    }
}

class MyFirebaseCategory : JSONSerializable {
    var name : String?
    var uId : String?
    
    var dict : [String : Any] { return ["name": self.name ?? "", "uid": self.uId ?? ""] }
}

class MyFirebaseItem : JSONSerializable {
    var name : String?
    var categoryId : String?
    var createDate : Date?
    var expiryDate : Date?
    var purchaseDate : Date?
    var replacementDate : Date?
    var description : String?
    var imgBill : String?
    var price : String?
    var uid : String?
    
    var dict : [String : Any] { return ["name": self.name ?? "",
                                        "categoryId": self.categoryId ?? "",
                                        "createDate": self.createDate ?? "",
                                        "expiryDate": self.expiryDate ?? "",
                                        "purchaseDate": self.purchaseDate ?? "",
                                        "replacementDate": self.replacementDate ?? "",
                                        "description": self.description ?? "",
                                        "imgBill": self.imgBill ?? "",
                                        "price": self.price ?? "",
                                        "uid": self.uid ?? "",
    ] }
}

class MyItemsCategory  {
    var documentID : String?
    var name : String?
    var uid : String?
}

class MyItemsInformation : NSObject {
    var documentID : String?
    var name : String?
    var categoryId : String?
    var createDate : Timestamp?
    var expiryDate : Timestamp?
    var purchaseDate : Timestamp?
    var replacementDate : Timestamp?
    var description1 : String?
    var imgBill : String?
    var price : String?
    var uid : String?
}
