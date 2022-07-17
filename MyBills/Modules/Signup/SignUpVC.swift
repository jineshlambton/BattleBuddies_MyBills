//
//  SignUpVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit

class SignUpVC: BaseVC {
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var viewNavigationBAr: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSignUpInstruction: UILabel!
    
    @IBOutlet weak var txtFirstName: MyTextField!
    @IBOutlet weak var txtLastName: MyTextField!
    @IBOutlet weak var txtEmailAddress: MyTextField!
    @IBOutlet weak var txtPassword: MyTextField!
    @IBOutlet weak var txtConfirmPassword: MyTextField!
    
    @IBOutlet weak var btnSignup: MyButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    //MARK: - Custom methods
    
    func setUpUI() {
        viewNavigationBAr.backgroundColor = MyColor.theme.color
        lblSignUpInstruction.setLBL(text: "LBL_ENTER_YOUR_DETAILS".localizedLanguage(), font: .LBL_SUB_TITLE, textcolor: .black)
        lblTitle.setLBL(text: "NAV_TITLE_REGISTER".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        txtFirstName.placeholder = "TXT_PLACEHOLDER_FIRSTNAME".localizedLanguage()
        txtLastName.placeholder = "TXT_PLACEHOLDER_LASTNAME".localizedLanguage()
        txtEmailAddress.placeholder = "TXT_PLACEHOLDER_EMAIL".localizedLanguage()
        txtPassword.placeholder = "TXT_PLACEHOLDER_PWD".localizedLanguage()
        txtConfirmPassword.placeholder = "TXT_PLACEHOLDER_CONFIRM_PWD".localizedLanguage()
        
        btnSignup.setTitle("BTN_SIGNUP".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        
        txtEmailAddress.setUpUsernameField()
        txtPassword.setUpPasswordField()
        txtConfirmPassword.setUpPasswordField()
    }

    //MARK: - Tap methods
    @IBAction func btnSignUpTapped(_ sender: Any) {
        btnSignup.reloadControl()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

