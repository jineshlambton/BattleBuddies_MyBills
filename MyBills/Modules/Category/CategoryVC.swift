//
//  CategoryVC.swift
//  MyBills
//
//  Created by Vraj Patel on 24/07/22.
//

import UIKit

class CategoryVC: BaseVC {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtCategory: MyTextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var navBarView: UIView!
    
    var selectedCategory : MyItemsCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        getCategoryAPICall()
    }
    
    // MARK: - Custom methods
    
    private func getCategoryAPICall() {
        showProgress()
        MyFirebaseDataStore.instace.delegate = self
        MyFirebaseDataStore.instace.getCategories()
    }
    
    private func setUpUI() {
        navBarView.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_CATEGORY".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        txtCategory.placeholder = "TXT_PLACEHOLDER_CATEGORY".localizedLanguage()
        
        btnAdd.setTitle("BTN_ADD".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        setButtonUI()
        
        tblView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        txtCategory.delegate = self
        txtCategory.clearButtonMode = .always
    }

    private func setButtonUI() {
        btnAdd.titleLabel?.font = .BTN_NORAML
        btnAdd.backgroundColor = MyColor.theme.color
        btnAdd.setTitleColor(.white, for: .normal)
    }
    
    private func addCategoryApiCall() {
        let objCategory = MyFirebaseCategory()
        objCategory.name = txtCategory.text!
        objCategory.uId = MyUserDefault.instace.getLoggedInUser() ?? ""
        MyFirebaseDataStore.instace.addCategory(category: objCategory)
    }
    
    // MARK: - Button tap methods
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        if ((txtCategory.text?.isEmpty) != nil) {
            if selectedCategory == nil {
                addCategoryApiCall()
            } else {
                selectedCategory?.name = txtCategory.text!
                MyFirebaseDataStore.instace.updateCategory(category: selectedCategory!)
            }
        } else {
            showAlert(msg: "ALERT_CATEGORY_EMPTY")
        }
        
    }
}

extension CategoryVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyFirebaseDataStore.instace.arrCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        cell.setUpUI()
        cell.selectionStyle = .none
        cell.lblTitle.text = MyFirebaseDataStore.instace.arrCategory[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = MyFirebaseDataStore.instace.arrCategory[indexPath.row]
        txtCategory.text = selectedCategory!.name ?? ""
        btnAdd.setTitle("BTN_UPDATE".localizedLanguage(), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Tapped at : \(indexPath.row)")
            MyFirebaseDataStore.instace.deleteCategory(id: MyFirebaseDataStore.instace.arrCategory[indexPath.row].documentID!)
        }
    }
    
}

extension CategoryVC : MyFirebaseDataStoreDelegate {
    func categoryAddedSuccessfully() {
        txtCategory.text = ""
        showAlert(msg: "ALERT_CATEGORY_ADDED")
        tblView.reloadData()
        getCategoryAPICall()
    }
    
    func categorySynced() {
        txtCategory.text = ""
        hideProgress()
        tblView.reloadData()
    }
    
    func deletedCategorySuccessfully() {
        txtCategory.text = ""
        tblView.reloadData()
        showAlert(msg: "ALERT_CATEGORY_DELETED")
        getCategoryAPICall()
    }
    
    func updatedCategorySuccessfully() {
        txtCategory.text = ""
        selectedCategory = nil
        tblView.reloadData()
        btnAdd.setTitle("BTN_ADD".localizedLanguage(), for: .normal)
        getCategoryAPICall()
    }
}

extension CategoryVC : UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        selectedCategory = nil
        btnAdd.setTitle("BTN_ADD".localizedLanguage(), for: .normal)
        return false
    }
}
