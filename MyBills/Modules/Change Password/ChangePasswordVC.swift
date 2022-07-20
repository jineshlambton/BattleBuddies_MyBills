//
//  ChangePasswordVC.swift
//  MyBills
//
//  Created by Vraj Patel on 20/07/22.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtOldPassword: MyTextField!
    @IBOutlet weak var txtNewPassword: MyTextField!
    @IBOutlet weak var txtConfirmPassword: MyTextField!
    
    @IBOutlet weak var btnSave: MyButton!
    @IBOutlet weak var viewNavBar: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    // MARK: - Custom methods
    
    private func setUpUI() {
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_CHANGE_PASSWORD".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        
        txtOldPassword.placeholder = "TXT_PLACEHOLDER_OLD_PWD".localizedLanguage()
        txtNewPassword.placeholder = "TXT_PLACEHOLDER_NEW_PWD".localizedLanguage()
        txtConfirmPassword.placeholder = "TXT_PLACEHOLDER_CONFIRM_PWD".localizedLanguage()
        
        btnSave.setTitle("BTN_SAVE".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
    }
    
    // MARK: - Button tap methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        
    }
    
}
