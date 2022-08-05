//
//  HowToUseVC.swift
//  MyBills
//
//  Created by Vraj Patel on 03/08/22.
//

import UIKit
import WebKit

class HowToUseVC: UIViewController {
    
    @IBOutlet weak var viewNarBar: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewNarBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_HOW_TO_USE".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        btnBack.setTitle("", for: .normal)
        
        if let path = Bundle.main.path(forResource: "Sample", ofType: "pdf") {
            var url = URL(fileURLWithPath: path)
            webView.load(URLRequest(url: url))
        }
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    
    

}
