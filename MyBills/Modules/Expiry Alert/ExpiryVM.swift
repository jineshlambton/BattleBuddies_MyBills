//
//  ExpiryVM.swift
//  MyBills
//
//  Created by Vraj Patel on 31/07/22.
//

import Foundation

@objc protocol ExpiryVMDelegate : NSObjectProtocol {
    @objc optional func categorySynced()
}

class ExpiryVM : NSObject {
    
    weak var delegate : ExpiryVMDelegate?
    
    var arrItem = [MyItemsInformation]()
    
    override init() {
        super.init()
        arrItem = MyFirebaseDataStore.instace.arrItem
    }
    
    func currentWeekExpiryItems() -> [MyItemsInformation] {
        let monday = Date().mondayOfTheSameWeek.addDays(numberOfDays: 7)
        arrItem = arrItem.filter({ item in
            return item.expiryDate != nil
        })
        let filteredArray = arrItem.filter { item in
            
            return item.expiryDate!.dateValue() > monday && item.expiryDate!.dateValue() < monday.addDays(numberOfDays: 7)
        }
        return filteredArray
    }
}
