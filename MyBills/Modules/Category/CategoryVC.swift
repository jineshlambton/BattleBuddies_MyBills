//
//  CategoryVC.swift
//  MyBills
//
//  Created by Vraj Patel on 24/07/22.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtCategory: MyTextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var navBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    // MARK: - Custom methods
    
    private func setUpUI() {
        navBarView.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_CATEGORY".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        txtCategory.placeholder = "TXT_PLACEHOLDER_CATEGORY".localizedLanguage()
        
        btnAdd.setTitle("BTN_ADD".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        setButtonUI()
        
        tblView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
    }

    private func setButtonUI() {
        btnAdd.titleLabel?.font = .BTN_NORAML
        btnAdd.backgroundColor = MyColor.theme.color
        btnAdd.setTitleColor(.white, for: .normal)
    }
    
    // MARK: - Button tap methods
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        
    }
}

extension CategoryVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        cell.setUpUI()
        cell.selectionStyle = .none
        cell.lblTitle.text = "asd"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        txtCategory.text = ""
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Tapped at : \(indexPath.row)")
        }
    }
    
}
