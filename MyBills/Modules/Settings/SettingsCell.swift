//
//  SettingsCell.swift
//  MyBills
//
//  Created by Vraj Patel on 18/07/22.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var viewCard: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI() {
        lblTitle.setLBL(text: "", font: .LBL_SUB_TITLE, textcolor: .black)
        viewCard.backgroundColor = MyColor.cardView.color
        viewCard.layer.cornerRadius = 15.0
    }
    
}
