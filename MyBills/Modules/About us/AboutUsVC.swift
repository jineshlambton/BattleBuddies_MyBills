//
//  AboutUsVC.swift
//  MyBills
//
//  Created by Vraj Patel on 03/08/22.
//

import UIKit

class AboutUsVC: UIViewController {
    
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDevelopedBy: UILabel!
    
    @IBOutlet weak var btnBack: UIButton!
    

    //MARK: - Viewcontroller method
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_ABOUT_US".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        
        lblDevelopedBy.numberOfLines = 0
        lblDevelopedBy.setLBL(text: "", font: .LBL_TITLE, textcolor: .black)
        lblDevelopedBy.text = "Developed by \n\n Team :- Battle buddies \n\n Jinesh Patel \n Dhairya Bhavsar \n Vraj Patel \n Jenish Chovatiya \n Mehul Patel"
        btnBack.setTitle("", for: .normal)
    }

    //MARK: - Button tap methods

    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
