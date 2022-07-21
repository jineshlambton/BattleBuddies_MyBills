//
//  AddItemVC.swift
//  MyBills
//
//  Created by Vraj Patel on 20/07/22.
//

import UIKit
import SwiftyMenu


class AddItemVC: BaseVC {
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtItemName: MyTextField!
    
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
    @IBOutlet weak var viewCategory1: SwiftyMenu!
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var txtPrice: MyTextField!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var viewDescription: UIView!
    
    @IBOutlet weak var imgBill: UIImageView!
    @IBOutlet weak var viewBill: UIView!
    
    @IBOutlet weak var btnAdd: MyButton!
    @IBOutlet weak var btnAddBill: UIButton!
    
    
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
        btnAddBill.setTitle("", for: .normal)
        btnCategory.setTitle("", for: .normal)
        setDateViewUI(view: viewPurchaseDate)
        setDateViewUI(view: viewExpiryDate)
        setDateViewUI(view: viewReplacementDate)
        setDateViewUI(view: viewDescription)
        setDateViewUI(view: viewBill)
//        setDateViewUI(view: viewCategory)
        
        txtItemName.placeholder = "TXT_PLACEHOLDER_ITEM_NAME".localizedLanguage()
        txtPrice.placeholder = "TXT_PLACEHOLDER_ITEM_PRICE".localizedLanguage()
        
        lblPurchaseDate.setLBL(text: "Purchase Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblExpiryDate.setLBL(text: "Expiry Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblReplacementDate.setLBL(text: "Replacement Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblCategory.setLBL(text: "Select Category : ", font: .LBL_SUB_TITLE, textcolor: .black)
        imgBill.image = UIImage(named: "placeholder")
        
        setUpDropdown()
    }
    
    private func showDatePicker(date: Date?) {
        let alert = UIAlertController(title: "My Bills", message: "Select Date", preferredStyle: .alert)
        alert.addDatePicker(mode: .date, date: date, minimumDate: Date(), maximumDate: Date()) { date in
            print("Date : \(date)")
        }
        alert.addAction(title: "Ok", color: .black, style: .cancel)

        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpDropdown() {
        var codeMenuAttributes = SwiftyMenuAttributes()
        codeMenuAttributes.multiSelect = .disabled
        codeMenuAttributes.separatorStyle = .value(color: .white, isBlured: false, style: .none)
        codeMenuAttributes.border = .value(color: MyColor.textFieldBorder.color, width: 1.0)
        codeMenuAttributes.roundCorners = .all(radius: 10)
        codeMenuAttributes.arrowStyle = .value(isEnabled: true, image: UIImage(named: "dropdown"))
        
        self.viewCategory1.delegate = self
        self.viewCategory1.configure(with: codeMenuAttributes)
        let obj1 = MyCategory(id: 1, name: "Category 1")
        let obj2 = MyCategory(id: 2, name: "Category 2")
        self.viewCategory1.items = [obj1, obj2]
//        DispatchQueue.main.async {
//            self.viewCategory1.selectedIndex = 1
//        }
    }
    
    override func getPickedImage(img: UIImage) {
        imgBill.image = img
    }
    
    // MARK: - Button tapped methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPurchaseDateTapped(_ sender: Any) {
        self.showDatePicker(date: Date())
    }
    
    @IBAction func btnExpirtyDateTapped(_ sender: Any) {
        self.showDatePicker(date: Date())
    }
    
    @IBAction func btnReplacementDateTapped(_ sender: Any) {
        self.showDatePicker(date: Date())
    }
    
    @IBAction func btnCategoryTapped(_ sender: Any) {
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
    }
    
    @IBAction func btnAddImageTapped(_ sender: Any) {
        openActionSheetToPickImage()
    }
    
    
}

extension AddItemVC : SwiftyMenuDelegate {
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        print("didSelectItem : \(item.displayableValue), index : \(index)")
    }
    
    func swiftyMenu(willExpand swiftyMenu: SwiftyMenu) {
        print("willExpand")
    }
    
    func swiftyMenu(didExpand swiftyMenu: SwiftyMenu) {
        print("didExpand")
    }
    
    func swiftyMenu(willCollapse swiftyMenu: SwiftyMenu) {
        print("willCollapse")
    }
    
    func swiftyMenu(didCollapse swiftyMenu: SwiftyMenu) {
        print("didCollapse")
    }
}

struct MyCategory {
    let id: Int
    let name: String
}

extension MyCategory: SwiftyMenuDisplayable {
    public var displayableValue: String {
        return self.name
    }

    public var retrievableValue: Any {
        return self.id
    }
}
