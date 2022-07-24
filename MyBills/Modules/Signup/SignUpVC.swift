//
//  SignUpVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit
import Firebase

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
    
    private func isValidInformation() -> Bool {
        if (txtFirstName.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_FIRST_NAME")
            return false
        } else if (txtLastName.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_LAST_NAME")
            return false
        } else if (txtEmailAddress.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_EMAIL_ADDRESS")
            return false
        } else if (txtEmailAddress.text?.isValidEmail())! == false {
            showAlert(msg: "ALERT_ENTER_VALID_EMAIL_ADDRESS")
            return false
        } else if (txtPassword.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_PASSWORD")
            return false
        }
        else if (txtConfirmPassword.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_CONFIRM_PASSWORD")
            return false
        } else if (txtPassword.text! != txtConfirmPassword.text!) {
            showAlert(msg: "ALERT_PWD_CONFIRM_PWD_NOT_MATCHING")
            return false
        }
        return true
    }

    private func createUserOnAuthentication() {
        MyFirebaseAuth.instace.delegate = self
        let objUser = MyFirebaseUser()
        objUser.emailAddress = txtEmailAddress.text!
        objUser.password = txtPassword.text!
        MyFirebaseAuth.instace.createUser(user: objUser)
    }
    
    private func createUserApiCall(uId : String) {
        let objUser = MyFirebaseUser()
        objUser.firstName = txtFirstName.text!
        objUser.lastName = txtLastName.text!
        objUser.emailAddress = txtEmailAddress.text!
        objUser.uID = uId
        MyFirebaseDataStore.instace.delegate = self
        MyFirebaseDataStore.instace.addUser(user: objUser)
    }
    
    private func resetUI() {
        txtFirstName.text = ""
        txtLastName.text = ""
        txtPassword.text = ""
        txtConfirmPassword.text = ""
        txtEmailAddress.text = ""
    }
    
    //MARK: - Tap methods
    @IBAction func btnSignUpTapped(_ sender: Any) {
        if isValidInformation() {
            if Util.isNetworkAvailable() {
                showProgress()
                createUserOnAuthentication()
            } else {
                showAlert(msg: Constant.MESSGAE.CHECK_INTERNET_CONECTION)
            }
        }
        btnSignup.reloadControl()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpVC : MyFirebaseDataStoreDelegate {
    func userAddedSuccessfully() {
        hideProgress()
        showAlertWithOk(self, msg: "ALERT_USER_CREATED_SUCCESSFULLY") { okAlert in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func userExist() {
        hideProgress()
        showAlert(msg: "ALERT_USER_EXIST")
        txtEmailAddress.text = ""
    }
}

extension SignUpVC : MyFirebaseDelegate {
    func userCreatedSuccessfully(user: User) {
        createUserApiCall(uId: user.uid)
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
}

