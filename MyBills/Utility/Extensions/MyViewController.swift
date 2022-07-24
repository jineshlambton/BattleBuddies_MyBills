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
    
//    var sceneDelegate: SceneDelegate? {
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//              let delegate = windowScene.delegate as? SceneDelegate else { return nil }
//        return delegate
//    }
//    
//    var appDelegate: AppDelegate {
//            return UIApplication.shared.delegate as! AppDelegate
//    }
//    
//    var window: UIWindow? {
//        if #available(iOS 13, *) {
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                  let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
//            return window
//        }
//        
//        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
//        return window
//    }
}
