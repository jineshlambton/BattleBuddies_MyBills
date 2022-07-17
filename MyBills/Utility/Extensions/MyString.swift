//
//  MyString.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import Foundation

extension String {

    func localizedLanguage() -> String
    {
        let strLang = "en"
        
        let path = Bundle.main.path(forResource: strLang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
