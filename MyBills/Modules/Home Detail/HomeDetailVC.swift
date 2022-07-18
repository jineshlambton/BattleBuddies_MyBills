//
//  HomeDetailVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit

class HomeDetailVC: UIViewController {
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    // MARK: - Custom methods
    
    private func setUpUI() {
        imgBill.image = UIImage(named: "placeholder")
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_HOME_DETAIL".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        
        btnDelete.setTitle("BTN_DELETE".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        btnEdir.setTitle("", for: .normal)
        lblName.setLBL(text: "iPhone 12", font: .LBL_TITLE, textcolor: .black)
        lblPrice.setLBL(text: "$1300", font: .LBL_TITLE, textcolor: .black)
        lblDescription.setLBL(text: "Bough iPhone on Christmas", font: .LBL_SUB_DATE, textcolor: .black)
        lblPurchaseDate.setLBL(text: "Purchase date : 17th July, 2022", font: .LBL_SUB_TITLE, textcolor: .black)
        lblExpiryDate.setLBL(text: "Expiry date : 17th July, 2023", font: .LBL_SUB_TITLE, textcolor: .black)
        lblReplacementDate.setLBL(text: "Replacement date : 17th August, 2022", font: .LBL_SUB_TITLE, textcolor: .black)
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
    }
    
    @IBAction func btnDeleteTapped(_ sender: Any) {
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
