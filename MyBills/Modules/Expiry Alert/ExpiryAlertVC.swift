//
//  ExpiryAlertVC.swift
//  MyBills
//
//  Created by Vraj Patel on 21/07/22.
//

import UIKit

class ExpiryAlertVC: UIViewController {

    
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var viewNavBar: UIView!
    
    var expiryVm = ExpiryVM()
    var arrItems = [MyItemsInformation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        arrItems = expiryVm.currentWeekExpiryItems()
    }
    
    //MARK: - Custom methods
    
    private func setUpUI() {
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_EXPIRY_ALERT".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        lblHeader.setLBL(text: "Date :- \(Date().mondayOfTheSameWeek.addDays(numberOfDays: 7).dateString()) - \(Date().mondayOfTheSameWeek.addDays(numberOfDays: 14).dateString())".localizedLanguage(), font: .LBL_SUB_TITLE, textcolor: .black)
        btnBack.setTitle("", for: .normal)
        tblView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }
    
    //MARK: - Button tap methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ExpiryAlertVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.selectionStyle = .none
        cell.setUpUI()
        cell.setData(data: arrItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objHomeDetailVC = HomeDetailVC(nibName: "HomeDetailVC", bundle: nil)
        objHomeDetailVC.objMyItemInfo = arrItems[indexPath.row]
        objHomeDetailVC.isFromExpiryAlert = true
        self.navigationController?.pushViewController(objHomeDetailVC, animated: true)
    }
    
}
