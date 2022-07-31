//
//  ChangePasswordVC.swift
//  MyBills
//
//  Created by Vraj Patel on 20/07/22.
//

import UIKit
import Firebase

class ChangePasswordVC: BaseVC {
    @IBOutlet weak var lblLoginInfo: UILabel!
    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var viewPassword: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtNewPassword: MyTextField!
    @IBOutlet weak var txtConfirmPassword: MyTextField!
    
    @IBOutlet weak var btnSave: MyButton!
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var txtUsername: MyTextField!
    @IBOutlet weak var txtPassword: MyTextField!
    @IBOutlet weak var btnLogin: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    // MARK: - Custom methods
    
    private func setUpUI() {
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_CHANGE_PASSWORD".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        
//        txtOldPassword.placeholder = "TXT_PLACEHOLDER_OLD_PWD".localizedLanguage()
        txtNewPassword.placeholder = "TXT_PLACEHOLDER_NEW_PWD".localizedLanguage()
        txtConfirmPassword.placeholder = "TXT_PLACEHOLDER_CONFIRM_PWD".localizedLanguage()
        
        txtUsername.placeholder = "TXT_PLACEHOLDER_USERNAME".localizedLanguage()
        txtPassword.placeholder = "TXT_PLACEHOLDER_PASSWORD".localizedLanguage()
        txtUsername.setUpUsernameField()
        
        btnSave.setTitle("BTN_SAVE".localizedLanguage(), for: .normal)
        btnLogin.setTitle("BTN_LOGIN".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        viewPassword.isHidden = true
        viewLogin.isHidden = false
        
        lblLoginInfo.setLBL(text: "LBL_CHANGE_PWD_LOGIN_INFO".localizedLanguage(), font: .LBL_TITLE, textcolor: .black)
    }
    
    private func isValidInformationForLogin() -> Bool {
        if (txtUsername.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_EMAIL_ADDRESS")
            return false
        }
        else if (txtUsername.text?.isValidEmail())! == false {
            showAlert(msg: "ALERT_ENTER_VALID_EMAIL_ADDRESS")
            return false
        }
        else if (txtPassword.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_PASSWORD")
            return false
        }
        return true
    }
    
    private func isValidInformationForPwd() -> Bool {
        if (txtNewPassword.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_PASSWORD")
            return false
        }
        else if (txtConfirmPassword.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_CONFIRM_PASSWORD")
            return false
        } else if (txtNewPassword.text! != txtConfirmPassword.text!) {
            showAlert(msg: "ALERT_PWD_CONFIRM_PWD_NOT_MATCHING")
            return false
        }
        return true
    }
    
    private func loginApiCall() {
        MyFirebaseAuth.instace.delegate = self
        let user = MyFirebaseUser()
        user.emailAddress = txtUsername.text!
        user.password = txtPassword.text!
        showProgress()
        MyFirebaseAuth.instace.login(user: user)
    }
    
    private func resetUI() {
        txtUsername.text = ""
        txtPassword.text = ""
    }
    
    // MARK: - Button tap methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        if isValidInformationForPwd() {
            if Util.isNetworkAvailable() {
                showProgress()
                MyFirebaseAuth.instace.changePwd(pwd: txtConfirmPassword.text!)
            } else {
                showAlert(msg: Constant.MESSGAE.CHECK_INTERNET_CONECTION)
            }
        }
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        
        if isValidInformationForLogin() {
            if Util.isNetworkAvailable() {
                loginApiCall()
            } else {
                showAlert(msg: Constant.MESSGAE.CHECK_INTERNET_CONECTION)
            }
        }
    }
}

extension ChangePasswordVC : MyFirebaseDelegate {
    func isAuthenticatedUser(user : User) {
        hideProgress()
        showAlertWithOk(self, msg: "ALERT_LOGIN_SUCCESSFUL") { [self] okAlert in
            viewPassword.isHidden = false
            viewLogin.isHidden = true
            
        }
    }
    
    func inValidUserDetails() {
        resetUI()
        hideProgress()
        showAlert(msg: "ALERT_INVALID_USER")
    }
     
    func userNotFound() {
        resetUI()
        hideProgress()
        showAlert(msg: "ALERT_USER_NOT_FOUND")
    }
    
    func passwordChangedSuccessfully() {
        hideProgress()
        showAlertWithOk(self, msg: "ALERT_PASSWORD_CHANGE_SUCCESS") { okAction in
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
