//
//  LoginVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: BaseVC {
    
    let GooglesignInConfig = GIDConfiguration(clientID:"735837895236-grtola98mi08i4h073tb3ohgbee2200s.apps.googleusercontent.com")
        
    
    @IBOutlet weak var txtUsername: MyTextField!
    @IBOutlet weak var txtPassword: MyTextField!
    
    @IBOutlet weak var btnLogin: MyButton!
    @IBOutlet weak var btnForgotPwd: UIButton!
    
    @IBOutlet weak var btnSignUp: MyButton!
    
    @IBOutlet weak var btnGoogleLogin: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        txtUsername.text = "jinesh@gmail.com"
        txtPassword.text = "jinesh"
        isLoggedInUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnLogin.reloadControl()
        btnSignUp.reloadControl()
    }
    //MARK: - Custom methods
    
    private func isLoggedInUser() {
        if let _ = MyUserDefault.instace.getLoggedInUser() {
            redirectToHome()
        }
    }
    
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
    
    private func redirectToHome() {
        let objHomeVC = HomeVC(nibName: "HomeVC", bundle: nil)
        let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
        let nav = UINavigationController(rootViewController: objHomeVC)
        nav.navigationBar.isHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    //MARK: - Button tap methods
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        btnLogin.reloadControl()
        if isValidInformation() {
            if Util.isNetworkAvailable() {
                loginApiCall()
            } else {
                showAlert(msg: Constant.MESSGAE.CHECK_INTERNET_CONECTION)
            }
        }
    }
    
    @IBAction func btnForgotPwdTapped(_ sender: Any) {
        let objForgotPwdVC = ForgotPwdVC(nibName: "ForgotPwdVC", bundle: nil)
        self.navigationController?.pushViewController(objForgotPwdVC, animated: true)
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        btnSignUp.reloadControl()
        let objSignupVC = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.navigationController?.pushViewController(objSignupVC, animated: true)
    }
    @IBAction func btnGoogleTapped(_ sender: Any) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            
            if let error = error {
                print(error)
                return
            }
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print(error)
                    return
                    
                }
                if let objResult = result {
                    MyUserDefault.instace.setLoggedInUser(user: objResult.user)
                    print("login success")
                    self.redirectToHome()
                }
            }
            
        }
        
    }
}

extension LoginVC : MyFirebaseDelegate {
    func isAuthenticatedUser(user : User) {
        hideProgress()
        showAlertWithOk(self, msg: "ALERT_LOGIN_SUCCESSFUL") { [self] okAlert in
            resetUI()
            redirectToHome()
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
}
