//
//  SettingsVC.swift
//  MyBills
//
//  Created by Vraj Patel on 18/07/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class SettingsVC: BaseVC {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnLogout: MyButton!
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    var arrSettingsOptions = ["Manage category", "Expiry Alert", "Change Password", "How to use?", "About us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        tblView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
    }

    // MARK: - Custom methods
    
    func setUpUI() {
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_SETTINGS".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        
        btnLogout.setTitle("BTN_LOGOUT".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
    }
    
    // MARK: - Button tap methods
    
    @IBAction func btnLogoutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        MyUserDefault.instace.setLoggedInUser()
        showProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideProgress()
            let objLoginVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
            let nav = UINavigationController(rootViewController: objLoginVc)
            nav.navigationBar.isHidden = true
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SettingsVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSettingsOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
        cell.setUpUI()
        cell.selectionStyle = .none
        cell.lblTitle.text = arrSettingsOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // Manage category
            print("")
            let objCategoryVC = CategoryVC(nibName: "CategoryVC", bundle: nil)
            self.navigationController?.pushViewController(objCategoryVC, animated: true)
        case 1:
            // Expiry alert
            let objExpiryAlertVC = ExpiryAlertVC(nibName: "ExpiryAlertVC", bundle: nil)
            self.navigationController?.pushViewController(objExpiryAlertVC, animated: true)
        case 2:
            // Chaneg password
            let objChangePwdVC = ChangePasswordVC(nibName: "ChangePasswordVC", bundle: nil)
            self.navigationController?.pushViewController(objChangePwdVC, animated: true)
        case 3:
            print("")
            let objHowToUseVC = HowToUseVC(nibName: "HowToUseVC", bundle:  nil)
            self.navigationController?.pushViewController(objHowToUseVC, animated: true)
        case 4:
            print("")
            let objAboutUsVC = AboutUsVC(nibName: "AboutUsVC", bundle: nil)
            self.navigationController?.pushViewController(objAboutUsVC, animated: true)
        default:
            print("")
            
        }
    }
    
}
