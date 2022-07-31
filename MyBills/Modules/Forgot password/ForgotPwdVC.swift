//
//  ForgotPwdVC.swift
//  MyBills
//
//  Created by Vraj Patel on 31/07/22.
//

import UIKit

class ForgotPwdVC: BaseVC {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtEmail: MyTextField!
    @IBOutlet weak var btnSubmit: MyButton!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewNavBar: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    // MARK: - Custom methods
    
    private func setUpUI() {
        viewNavBar.backgroundColor = MyColor.theme.color
        
        lblTitle.setLBL(text: "NAV_TITLE_FORGOT_PWD".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        txtEmail.placeholder = "TXT_PLACEHOLDER_EMAIL".localizedLanguage()
        
        btnSubmit.setTitle("BTN_SUBMIT".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        
        txtEmail.setUpUsernameField()
    }

    // MARK: - Button tap methods
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        if (txtEmail.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_EMAIL_ADDRESS")
        } else if (txtEmail.text?.isValidEmail())! == false {
            showAlert(msg: "ALERT_ENTER_VALID_EMAIL_ADDRESS")
        } else {
            if Util.isNetworkAvailable() {
                showProgress()
                MyFirebaseAuth.instace.delegate = self
                MyFirebaseAuth.instace.forgetPwd(email: txtEmail.text!)
            } else {
                showAlert(msg: Constant.MESSGAE.CHECK_INTERNET_CONECTION)
            }
            
        }
    }
    
}

extension ForgotPwdVC : MyFirebaseDelegate {
    func passwordResetSentSuccessfully() {
        hideProgress()
        self.showAlertWithOk(self, msg: "ALERT_RECOVER_PWD_EMAIL_SENT") { okAction in
            self.navigationController?.popViewController(animated: true)
        }
    }
}
