//
//  FilterVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit

class FilterVC: BaseVC {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgDone: UIImageView!
    @IBOutlet weak var btnDone: UIButton!
    
    @IBOutlet weak var lblPriceTitle: UILabel!
    
    @IBOutlet weak var btnReset: MyButton!
    
    @IBOutlet weak var viewDate1: UIView!
    
    @IBOutlet weak var viewDate2: UIView!
    @IBOutlet weak var lblDate1: UILabel!
    @IBOutlet weak var lblDate2: UILabel!
    
    @IBOutlet weak var btnDate1: UIButton!
    @IBOutlet weak var btnDate2: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    //MARK: - Custom methods
    
    private func setUpUI() {
        navBarView.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_FILTER".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        btnReset.setTitle("BTN_RESET".localizedLanguage(), for: .normal)
        btnBack.setTitle("", for: .normal)
        btnDone.setTitle("", for: .normal)
        lblPriceTitle.setLBL(text: "LBL_PRICE".localizedLanguage(), font: .LBL_SUB_TITLE, textcolor: .black)
        lblDate1.setLBL(text: "Purchase Date : -", font: .LBL_SUB_TITLE, textcolor: .black)
        lblDate2.setLBL(text: "Expiry Date : -", font: .LBL_SUB_TITLE, textcolor: .black)
        btnDate1.setTitle("", for: .normal)
        btnDate2.setTitle("", for: .normal)
        btnCategory.setTitle("", for: .normal)
        curveView(view: viewDate1)
        curveView(view: viewDate2)
    }
    
    func curveView(view : UIView) {
        view.layer.borderColor = MyColor.textFieldBorder.color.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10.0
    }
    
    private func showDatePicker1(date: Date?) {
        let alert = UIAlertController(style: .alert, title: "Select Date", message: nil)
        alert.addDatePicker(mode: .date, date: date ?? Date(), minimumDate: Util.fromDate(year: 1900, month: 1, day: 1), maximumDate: Util.fromDate(year: 2100, month: 1, day: 1)) { date in
            print("Selected date 1 is : \(date)")
            self.lblDate1.text = "Purchase Date : \(date.dateString())"
        }
        alert.addAction(title: "Done", color: MyColor.theme.color, style: .cancel)
        self.present(alert, animated: true, completion: nil)
    }

    private func showDatePicker2(date: Date?) {
        let alert = UIAlertController(style: .alert, title: "Select Date", message: nil)
        alert.addDatePicker(mode: .date, date: date ?? Date(), minimumDate: Util.fromDate(year: 1900, month: 1, day: 1), maximumDate: Util.fromDate(year: 2100, month: 1, day: 1)) { date in
            print("Selected date 2 is : \(date)")
            self.lblDate2.text = "Expiry Date : \(date.dateString())"
        }
        alert.addAction(title: "Done", color: MyColor.theme.color, style: .cancel)
        self.present(alert, animated: true, completion: nil)
    }

    //MARK: - Button tap methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnResetTapped(_ sender: Any) {
        showDatePicker1(date: nil)
    }
    
    @IBAction func btnDatePicker1Tapped(_ sender: Any) {
        showDatePicker1(date: nil)
    }
    
    @IBAction func btnDatePicker2Tapped(_ sender: Any) {
        showDatePicker2(date: nil)
    }
    
    @IBAction func btnCategoryTapped(_ sender: Any) {
    }
}
