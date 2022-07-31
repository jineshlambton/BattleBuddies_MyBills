//
//  HomeVM.swift
//  MyBills
//
//  Created by Vraj Patel on 30/07/22.
//

import Foundation
import Firebase
import UIKit

@objc protocol HomeVMDelegate : NSObjectProtocol {
    @objc optional func itemSynced(arr : [MyItemsInformation])
    @objc optional func categorySynced()
    @objc optional func itemFiltered(arr : [MyItemsInformation])
}

class HomeVM : NSObject {
    
    weak var delegate : HomeVMDelegate?
    var arrItem = [MyItemsInformation]()
    var arrCategory = [MyItemsCategory]()
    var arrFilteredItem = [MyItemsInformation]()
    
    override init() {
        super.init()
        self.getCategory()
        self.getItems()
    }
    
    private func getCategory() {
        MyFirebaseDataStore.instace.getCategories()
    }
    
    func getItems() {
        MyFirebaseDataStore.instace.delegate = self
        MyFirebaseDataStore.instace.getItems()
    }
    
    func filteredItems(filter : FilterParameter) {
        arrFilteredItem.removeAll()
        
        let filteredArray = arrItem.filter { item in
            return item.categoryId == (filter.categoryId ?? item.categoryId) &&
            item.purchaseDate?.dateValue().dateString() == (filter.purchaseDate ?? item.purchaseDate?.dateValue())?.dateString() &&
            item.expiryDate?.dateValue().dateString() == (filter.expiryDate ?? item.expiryDate?.dateValue())?.dateString() &&
            (Int(item.price!)! <= (Int((filter.maxPrice ?? item.price)!)!) && Int(item.price!)! >= (Int((filter.minPrice ?? item.price)!))!)
        }
        
        arrFilteredItem = filteredArray
        delegate?.itemFiltered?(arr: arrFilteredItem)
        
        print(filteredArray)
    }
}

class FilterParameter : NSObject {
    var purchaseDate : Date?
    var expiryDate : Date?
    var categoryId : String?
    var minPrice : String?
    var maxPrice : String?
}

extension HomeVM : MyFirebaseDataStoreDelegate {
    func itemsSynced() {
        self.arrItem = MyFirebaseDataStore.instace.arrItem
//        self.arrFilteredItem = MyFirebaseDataStore.instace.arrItem
        self.delegate?.itemSynced?(arr: MyFirebaseDataStore.instace.arrItem)
    }
    
    func categorySynced() {
        self.arrCategory = MyFirebaseDataStore.instace.arrCategory
        self.delegate?.categorySynced?()
    }
}
