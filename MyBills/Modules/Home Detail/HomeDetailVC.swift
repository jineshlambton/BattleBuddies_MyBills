//
//  HomeDetailVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit

@objc protocol HomeDetailVCDelegate : NSObjectProtocol {
    @objc optional func deletedItemSuccessfully()
}

class HomeDetailVC: BaseVC {
    
    @IBOutlet weak var viewNavBar: UIView!
    
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnEdir: UIButton!
    @IBOutlet weak var imgEdir: UIImageView!
    
    
    @IBOutlet weak var imgBill: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblPurchaseDate: UILabel!
    
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var lblReplacementDate: UILabel!
    
    
    
    @IBOutlet weak var btnDelete: MyButton!
    
    var objMyItemInfo : MyItemsInformation?
    weak var delegate : HomeDetailVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setData()
    }
    
    // MARK: - Custom methods
    
    private func setData() {
        if let objItem = objMyItemInfo {
            lblName.text = objItem.name ?? ""
            lblPrice.text = "$" + (objItem.price ?? "")
            lblDescription.text = objItem.description1 ?? ""
            if let seconds = objItem.purchaseDate?.seconds {
                let strCreatedDate = Date(timeIntervalSince1970: Double(seconds)).dateString()
                lblPurchaseDate.text = "Purchase Date : " + strCreatedDate
            }
            if let seconds = objItem.expiryDate?.seconds {
                let strCreatedDate = Date(timeIntervalSince1970: Double(seconds)).dateString()
                lblExpiryDate.text = "Expiry Date : " + strCreatedDate
            }
            if let seconds = objItem.replacementDate?.seconds {
                let strCreatedDate = Date(timeIntervalSince1970: Double(seconds)).dateString()
                lblReplacementDate.text = "Replacement Date : " + strCreatedDate
            }
        } else {
            showAlertWithOk(self, msg: Constant.MESSGAE.SOMETHING_WENT_WRONG) { okAction in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setUpUI() {
        imgBill.image = UIImage(named: "placeholder")
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_HOME_DETAIL".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        
        btnDelete.setTitle("BTN_DELETE".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        btnEdir.setTitle("", for: .normal)
        lblName.setLBL(text: "-", font: .LBL_TITLE, textcolor: .black)
        lblPrice.setLBL(text: "-", font: .LBL_TITLE, textcolor: .black)
        lblDescription.setLBL(text: "-", font: .LBL_SUB_DATE, textcolor: .black)
        lblPurchaseDate.setLBL(text: "Purchase date : -", font: .LBL_SUB_TITLE, textcolor: .black)
        lblExpiryDate.setLBL(text: "Expiry date : -", font: .LBL_SUB_TITLE, textcolor: .black)
        lblReplacementDate.setLBL(text: "Replacement date : -", font: .LBL_SUB_TITLE, textcolor: .black)
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
    }
    
    @IBAction func btnDeleteTapped(_ sender: Any) {
        if let itemId = objMyItemInfo?.documentID {
            MyFirebaseDataStore.instace.delegate = self
            showProgress()
            MyFirebaseDataStore.instace.deleteItem(id: itemId)
        }
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HomeDetailVC : MyFirebaseDataStoreDelegate {
    func deletedItemSuccessfully() {
        hideProgress()
        self.showAlertWithOk(self, msg: "ALERT_ITEM_DELETED_SUCCESSFULLY") { [self] okAction in
            delegate?.deletedItemSuccessfully?()
            navigationController?.popViewController(animated: true)
        }
    }
    
    func deletedItemFailed() {
        hideProgress()
        showAlert(msg: Constant.MESSGAE.SOMETHING_WENT_WRONG)
    }
}
