//
//  SettingsVC.swift
//  MyBills
//
//  Created by Vraj Patel on 18/07/22.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnLogout: MyButton!
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    var arrSettingsOptions = ["Change Password", "How to use?", "About us", "Expiry Alert"]
    
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
        cell.lblTitle.text = arrSettingsOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
