//
//  AddItemVC.swift
//  MyBills
//
//  Created by Vraj Patel on 20/07/22.
//

import UIKit

class AddItemVC: UIViewController {
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    @IBOutlet weak var txtItemName: UITextField!
    
    @IBOutlet weak var lblPurchaseDate: UILabel!
    @IBOutlet weak var btnPurchaseDate: UIButton!
    @IBOutlet weak var viewPurchaseDate: UIView!
    
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var btnExpirtyDate: UIButton!
    @IBOutlet weak var viewExpiryDate: UIView!
    
    @IBOutlet weak var lblReplacementDate: UILabel!
    @IBOutlet weak var btnReplacementDate: UIButton!
    @IBOutlet weak var viewReplacementDate: UIView!
    
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    
    
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var viewDescription: UIView!
    
    @IBOutlet weak var imgBill: UIImageView!
    @IBOutlet weak var viewBill: UIView!
    
    @IBOutlet weak var btnAdd: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }

    // MARK: - Custom methods
    
    private func setDateViewUI(view : UIView) {
        view.layer.cornerRadius = 8.0
        view.layer.borderWidth = 0.5
        view.layer.borderColor = MyColor.textFieldBorder.color.cgColor
    }
    
    private func setUpUI() {
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_ITEM".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        
        btnAdd.setTitle("BTN_ADD".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        btnPurchaseDate.setTitle("", for: .normal)
        btnExpirtyDate.setTitle("", for: .normal)
        btnReplacementDate.setTitle("", for: .normal)
        btnCategory.setTitle("", for: .normal)
        setDateViewUI(view: viewPurchaseDate)
        setDateViewUI(view: viewExpiryDate)
        setDateViewUI(view: viewReplacementDate)
        setDateViewUI(view: viewDescription)
        setDateViewUI(view: viewBill)
        setDateViewUI(view: viewCategory)
        
        txtItemName.placeholder = "TXT_PLACEHOLDER_ITEM_NAME".localizedLanguage()
        txtPrice.placeholder = "TXT_PLACEHOLDER_ITEM_PRICE".localizedLanguage()
        
        lblPurchaseDate.setLBL(text: "Purchase Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblExpiryDate.setLBL(text: "Expiry Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblReplacementDate.setLBL(text: "Replacement Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblCategory.setLBL(text: "Select Category : ", font: .LBL_SUB_TITLE, textcolor: .black)
        imgBill.image = UIImage(named: "placeholder")
        
        
        
    }
    
    // MARK: - Button tapped methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPurchaseDateTapped(_ sender: Any) {
    }
    
    @IBAction func btnExpirtyDateTapped(_ sender: Any) {
    }
    
    @IBAction func btnReplacementDateTapped(_ sender: Any) {
    }
    
    @IBAction func btnCategoryTapped(_ sender: Any) {
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
    }
}
