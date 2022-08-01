//
//  AddItemVC.swift
//  MyBills
//
//  Created by Vraj Patel on 20/07/22.
//

import UIKit
import SwiftyMenu
import DropDown
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

@objc protocol AddItemVCDelegate : NSObjectProtocol {
    @objc optional func newItemAdded()
}

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
    @IBOutlet weak var viewCategory: UIView!
//    @IBOutlet weak var viewCategory1: SwiftyMenu!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var txtPrice: MyTextField!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var viewDescription: UIView!
    
    @IBOutlet weak var imgBill: UIImageView!
    @IBOutlet weak var viewBill: UIView!
    
    @IBOutlet weak var btnAdd: MyButton!
    @IBOutlet weak var btnAddBill: UIButton!
    
    weak var delegate : AddItemVCDelegate?
    var purchaseDate : Date?
    var expiryDate : Date?
    var replacementDate : Date?
    
    var isEdit = false
    
    private let dropDown = DropDown()
    private var arrCategoryTitle : [String] = [String]()
    private var selectedCategoryId : String?
    private var arrCategoryId : [String] = [String]()
    var objItemInfo : MyItemsInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        getCategoryAPICall()
        if isEdit {
            btnAdd.setTitle("BTN_UPDATE".localizedLanguage(), for: .normal)
            setData()
        }
    }

    // MARK: - Custom methods
    
    private func setData() {
        if let item = objItemInfo {
            if let name = item.name {
                txtItemName.text = name
            }
            if let categoryId = item.categoryId {
                let name = MyFirebaseDataStore.instace.getCategoryName(id: categoryId)
                lblCategory.text = name
                selectedCategoryId = categoryId
            }
            if let pDate = item.purchaseDate {
                lblPurchaseDate.text = "Purchase Date : \(pDate.dateValue().dateString())"
                purchaseDate = pDate.dateValue()
            }
            if let eDate = item.expiryDate {
                lblExpiryDate.text = "Expiry Date : \(eDate.dateValue().dateString())"
                expiryDate = eDate.dateValue()
            }
            if let rDate = item.replacementDate {
                lblReplacementDate.text = "Replacement date : \(rDate.dateValue().dateString())"
                replacementDate = rDate.dateValue()
            }
            if let price = item.price {
                txtPrice.text = price
            }
            if let description = item.description1 {
                txtViewDescription.text = description
            }
        }
    }
    
    private func addItemApiCall() {
        let objItem = MyFirebaseItem()
        objItem.name = txtItemName.text!
        objItem.price = txtPrice.text!
        objItem.purchaseDate = purchaseDate
        objItem.description = txtViewDescription.text!
        objItem.categoryId = selectedCategoryId!
        if let objRDate = replacementDate {
            objItem.replacementDate = objRDate
        }
        if let objEDate = expiryDate {
            objItem.expiryDate = objEDate
        }
        objItem.createDate = Date()
        objItem.uid = MyUserDefault.instace.getLoggedInUser() ?? ""
        
        MyFirebaseDataStore.instace.addItem(item: objItem)
    }
    
    private func updateItemApiCall() {
        let objItem = MyFirebaseItem()
        objItem.name = txtItemName.text!
        objItem.price = txtPrice.text!
        objItem.purchaseDate = purchaseDate
        objItem.description = txtViewDescription.text!
        objItem.categoryId = selectedCategoryId!
        if let objRDate = replacementDate {
            objItem.replacementDate = objRDate
        }
        if let objEDate = expiryDate {
            objItem.expiryDate = objEDate
        }
        objItem.createDate = Date()
        objItem.uid = MyUserDefault.instace.getLoggedInUser() ?? ""
        
        MyFirebaseDataStore.instace.updateItem(id: objItemInfo!.documentID!, item: objItem)
    }
    
    private func isValidInformation() -> Bool {
        if (txtItemName.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_ITEM_NAME")
            return false
        }  else if (purchaseDate == nil) {
            showAlert(msg: "ALERT_SELECT_PURCHASE_DATE")
            return false
        } else if (selectedCategoryId == nil) {
            showAlert(msg: "ALERT_SELECT_CATEGORY")
            return false
        } else if (txtPrice.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_PRICE")
            return false
        } else if (txtViewDescription.text?.isEmpty)! {
            showAlert(msg: "ALERT_ENTER_DESCRIPTION")
            return false
        }
        return true
    }

    
    private func sortCategoryTitle() {
        arrCategoryTitle.removeAll()
        arrCategoryTitle = MyFirebaseDataStore.instace.arrCategory.map { $0.name! }
        arrCategoryId = MyFirebaseDataStore.instace.arrCategory.map { $0.documentID! }
        dropDown.dataSource = arrCategoryTitle
    }
    
    private func getCategoryAPICall() {
        showProgress()
        MyFirebaseDataStore.instace.delegate = self
        MyFirebaseDataStore.instace.getCategories()
    }
    
    private func setDateViewUI(view : UIView) {
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 1
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
        setDateViewUI(view: viewCategory)
        
        txtItemName.placeholder = "TXT_PLACEHOLDER_ITEM_NAME".localizedLanguage()
        txtPrice.placeholder = "TXT_PLACEHOLDER_ITEM_PRICE".localizedLanguage()
        
        lblPurchaseDate.setLBL(text: "Purchase Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblExpiryDate.setLBL(text: "Expiry Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblReplacementDate.setLBL(text: "Replacement Date : ", font: .LBL_SUB_TITLE, textcolor: .black)
        lblCategory.setLBL(text: "Select Category : ", font: .LBL_SUB_TITLE, textcolor: .black)
        imgBill.image = UIImage(named: "placeholder")
        
        setUpDropdown()
    }
    
    private func showDatePicker(date: Date?, type : DatePickerType) {
        var title = ""
        var minDate = Date()
        if type == .purchaseDate {
            title = "Select purchase date".localizedLanguage()
            minDate = Util.fromDate(year: 1900, month: 1, day: 1)
        } else if type == .expiryDate {
            title = "Select expiry date".localizedLanguage()
            minDate = Date()
        } else if type == .replacementDate {
            title = "Select replacement date".localizedLanguage()
            minDate = Date()
        }
        let alert = UIAlertController(title: Util.applicationName, message: title, preferredStyle: .alert)
        
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: minDate, maximumDate: date) { [self] date in
            print("Date : \(date)")
            if type == .expiryDate {
                expiryDate = date
                lblExpiryDate.setLBL(text: "Expiry Date : \(date.dateString())", font: .LBL_SUB_TITLE, textcolor: .black)
            } else if type == .purchaseDate {
                purchaseDate = date
                lblPurchaseDate.setLBL(text: "Purchase Date : \(date.dateString())", font: .LBL_SUB_TITLE, textcolor: .black)
            } else if type == .replacementDate {
                replacementDate = date
                lblReplacementDate.setLBL(text: "Replacement Date : \(date.dateString())", font: .LBL_SUB_TITLE, textcolor: .black)
            }
        }
        alert.addAction(title: "OK_BTN_ON_ALERT".localizedLanguage(), color: .black, style: .cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setUpDropdown() {
        dropDown.anchorView = viewCategory
        dropDown.dataSource = arrCategoryTitle
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            lblCategory.text = item
            selectedCategoryId = arrCategoryId[index]
        }
    }
    
    override func getPickedImage(img: UIImage) {
        imgBill.image = img
    }
    
    // MARK: - Button tapped methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPurchaseDateTapped(_ sender: Any) {
        self.showDatePicker(date: Date(),type: .purchaseDate)
    }
    
    @IBAction func btnExpirtyDateTapped(_ sender: Any) {
        self.showDatePicker(date: Util.fromDate(year: 2100, month: 1, day: 1), type: .expiryDate)
    }
    
    @IBAction func btnReplacementDateTapped(_ sender: Any) {
        self.showDatePicker(date: Util.fromDate(year: 2050, month: 1, day: 1), type: .replacementDate)
    }
    
    @IBAction func btnCategoryTapped(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        
        if isValidInformation() {
            if Util.isNetworkAvailable() {
                showProgress()
                if isEdit {
                    updateItemApiCall()
                } else {
                    addItemApiCall()
                }
            } else {
                showAlert(msg: Constant.MESSGAE.CHECK_INTERNET_CONECTION)
            }
        }
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
extension AddItemVC : MyFirebaseDataStoreDelegate {
    func categorySynced() {
        hideProgress()
        sortCategoryTitle()
    }
    
    func itemAddedSuccessfully() {
        hideProgress()
        showAlertWithOk(self, msg: "ALERT_ITEM_ADDED_SUCCESSFULLY") { [self] okAction in
            delegate?.newItemAdded?()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func itemUpdatedSuccessfully() {
        hideProgress()
        NotificationCenter.default.post(name: Notification.Name("updateItemList"), object: nil)
        showAlertWithOk(self, msg: "ALERT_ITEM_UPDATED_SUCCESSFULLY") { [self] okAction in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
