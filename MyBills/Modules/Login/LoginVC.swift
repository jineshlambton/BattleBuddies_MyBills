//
//  LoginVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtUsername: MyTextField!
    @IBOutlet weak var txtPassword: MyTextField!
    
    @IBOutlet weak var btnLogin: MyButton!
    @IBOutlet weak var btnForgotPwd: UIButton!
    
    @IBOutlet weak var btnSignUp: MyButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnLogin.reloadControl()
        btnSignUp.reloadControl()
    }
    //MARK: - Custom methods
    
    private func setUpUI() {
        txtUsername.placeholder = "TXT_PLACEHOLDER_USERNAME".localizedLanguage()
        txtPassword.placeholder = "TXT_PLACEHOLDER_PASSWORD".localizedLanguage()
        txtUsername.setUpUsernameField()
        btnLogin.setTitle("BTN_LOGIN".localizedLanguage(), for: .normal)
        btnSignUp.setTitle("BTN_SIGNUP".localizedLanguage(), for: .normal)
        btnForgotPwd.setTitle("BTN_FORGOT_PASSWORD".localizedLanguage(), for: .normal)
    }
    
    private func isValidInformation() -> Bool {
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
    
    private func checkUser() {
        MyFirebaseAuth.instace.delegate = self
        let user = MyFirebaseUser()
        user.strEmail = txtUsername.text!
        user.strPassword = txtPassword.text!
        MyFirebaseAuth.instace.login(user: user)
    }
    
    private func resetUI() {
        txtUsername.text = ""
        txtPassword.text = ""
    }
    
    //MARK: - Button tap methods
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        btnLogin.reloadControl()
        if isValidInformation() {
            if Util.isNetworkAvailable() {
                checkUser()
            } else {
                showAlert(msg: Constant.MESSGAE.CHECK_INTERNET_CONECTION)
            }
        }
    }
    
    @IBAction func btnForgotPwdTapped(_ sender: Any) {
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        btnSignUp.reloadControl()
        let objSignupVC = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.navigationController?.pushViewController(objSignupVC, animated: true)
    }
}

extension LoginVC : MyFirebaseDelegate {
    func isAuthenticatedUser(user : User) {
        showAlertWithOk(self, msg: "ALERT_LOGIN_SUCCESSFUL") { [self] okAlert in
            resetUI()
            let objHomeVC = HomeVC(nibName: "HomeVC", bundle: nil)
            self.navigationController?.pushViewController(objHomeVC, animated: true)
        }
    }
    
    func inValidUserDetails() {
        resetUI()
        showAlert(msg: "ALERT_INVALID_USER")
    }
     
    func userNotFound() {
        resetUI()
        showAlert(msg: "ALERT_USER_NOT_FOUND")
    }
}
