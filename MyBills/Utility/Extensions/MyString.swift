//
//  MyString.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import Foundation

extension String {

    func localizedLanguage() -> String {
        let strLang = "en"
        
        let path = Bundle.main.path(forResource: strLang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    func isValidEmail() -> Bool {    
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
