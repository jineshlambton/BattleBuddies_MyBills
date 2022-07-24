//
//  MyViewController.swift
//  MyBills
//
//  Created by Vraj Patel on 24/07/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(msg: String) -> Void {
        let alertController = UIAlertController(title: Util.applicationName, message: msg.localizedLanguage(), preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK_BTN_ON_ALERT".localizedLanguage() , style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithOk(_ controller:UIViewController, msg:String, action:((UIAlertAction?) -> Void)?) {
        let alertController = UIAlertController(title: Util.applicationName, message: msg.localizedLanguage(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK_BTN_ON_ALERT".localizedLanguage(), style: .default, handler: action)
        
        alertController.addAction(okAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
