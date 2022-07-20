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
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }


    // MARK: - Custom methods
    
    private func setUpUI() {
        
    }
    
    // MARK: - Button tapped methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
