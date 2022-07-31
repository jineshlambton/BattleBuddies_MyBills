//
//  HomeCell.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgBill: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    
    @IBOutlet weak var viewCard: UIView!
    
    @IBOutlet weak var viewImageBill: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpUI() {
        lblDate.setLBL(text: "17th July, 2022", font: .LBL_DATE, textcolor: .black)
        lblItem.setLBL(text: "iPhone 12", font: .LBL_SUB_TITLE, textcolor: .black)
        lblExpiryDate.setLBL(text: "Expiry Date : 28th July", font: .LBL_SUB_DATE, textcolor: .black)
        lblCategory.setLBL(text: "Category : Work", font: .LBL_SUB_DATE, textcolor: .black)
        viewCard.backgroundColor = MyColor.cardView.color
        viewCard.layer.cornerRadius = 15.0
        imgBill.image = UIImage(named: "placeholder")
    }
    
    func setData(data : MyItemsInformation) {
        var strCreatedDate = ""
        var strExpiryDate = "-"
        if let _ = data.createDate?.seconds {
            strCreatedDate = Date(timeIntervalSince1970: Double(data.createDate!.seconds)).dateString()
        }
        if let _ = data.expiryDate?.seconds {
            strExpiryDate = Date(timeIntervalSince1970: Double(data.expiryDate!.seconds)).dateString()
        }
        lblDate.text = strCreatedDate
        lblItem.text = data.name ?? ""
        lblExpiryDate.text = "Expiry Date : " + strExpiryDate
        let strCategory = MyFirebaseDataStore.instace.getCategoryName(id: data.categoryId!)
        lblCategory.text = "Category : " + strCategory
        
    }
    
}
