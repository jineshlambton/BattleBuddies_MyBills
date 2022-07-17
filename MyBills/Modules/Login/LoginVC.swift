//
//  LoginVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit

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
    
    //MARK: - Button tap methods
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        btnLogin.reloadControl()
        let objHomeVC = HomeVC(nibName: "HomeVC", bundle: nil)
        self.navigationController?.pushViewController(objHomeVC, animated: true)
    }
    
    @IBAction func btnForgotPwdTapped(_ sender: Any) {
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        btnSignUp.reloadControl()
        let objSignupVC = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.navigationController?.pushViewController(objSignupVC, animated: true)
    }
}
