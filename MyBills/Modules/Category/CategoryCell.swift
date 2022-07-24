//
//  CategoryCell.swift
//  MyBills
//
//  Created by Vraj Patel on 24/07/22.
//

import UIKit

class CategoryCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI() {
        cardView.backgroundColor = MyColor.cardView.color
        lblTitle.setLBL(text: "", font: .LBL_SUB_TITLE, textcolor: .black)
        cardView.layer.cornerRadius = 15.0
    }
    
}
