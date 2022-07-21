//
//  FilterVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit
import SwiftyMenu
import RangeSeekSlider

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
    
    @IBOutlet weak var viewCategory: SwiftyMenu!
    @IBOutlet weak var priceRange: RangeSeekSlider!
    
    @IBOutlet weak var lblMinValue: UILabel!
    @IBOutlet weak var lblMaxValue: UILabel!
    
    
    
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
        lblMinValue.setLBL(text: "", font: .LBL_SUB_TITLE, textcolor: .black)
        lblMaxValue.setLBL(text: "", font: .LBL_SUB_TITLE, textcolor: .black)
        lblDate1.setLBL(text: "Purchase Date : -", font: .LBL_SUB_TITLE, textcolor: .black)
        lblDate2.setLBL(text: "Expiry Date : -", font: .LBL_SUB_TITLE, textcolor: .black)
        btnDate1.setTitle("", for: .normal)
        btnDate2.setTitle("", for: .normal)
        btnCategory.setTitle("", for: .normal)
        curveView(view: viewDate1)
        curveView(view: viewDate2)
        
        setUpDropdown()
        DispatchQueue.main.async {
            self.setUpPriceRange()
        }
        
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
    
    private func setUpDropdown() {
        var codeMenuAttributes = SwiftyMenuAttributes()
        codeMenuAttributes.multiSelect = .disabled
        codeMenuAttributes.separatorStyle = .value(color: .white, isBlured: false, style: .none)
        codeMenuAttributes.border = .value(color: MyColor.textFieldBorder.color, width: 1.0)
        codeMenuAttributes.roundCorners = .all(radius: 10)
        codeMenuAttributes.arrowStyle = .value(isEnabled: true, image: UIImage(named: "dropdown"))
        
        self.viewCategory.delegate = self
        self.viewCategory.configure(with: codeMenuAttributes)
        let obj1 = MyCategory(id: 1, name: "Category 1")
        let obj2 = MyCategory(id: 2, name: "Category 2")
        self.viewCategory.items = [obj1, obj2]
//        DispatchQueue.main.async {
//            self.viewCategory1.selectedIndex = 1
//        }
    }
    
    private func setUpPriceRange() {
        priceRange.delegate = self
        priceRange.minValue = 10
        priceRange.maxValue = 100
        priceRange.selectedMinValue = 20
        priceRange.selectedMaxValue = 80
        priceRange.hideLabels = false
        priceRange.labelsFixed = false
        priceRange.minLabelFont = .LBL_TITLE
        priceRange.maxLabelFont = .LBL_TITLE
        priceRange.disableRange = false
        lblMinValue.text = "Min : \(Int(priceRange.selectedMinValue))"
        lblMaxValue.text = "Max : \(Int(priceRange.selectedMaxValue))"
        
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

extension FilterVC : SwiftyMenuDelegate {
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

extension FilterVC : RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        print("didChange : \(minValue), : \(maxValue)")
        lblMinValue.text = "Min : \(Int(minValue))"
        lblMaxValue.text = "Max : \(Int(maxValue))"
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
//        print("didStartTouches: \(slider.minValue) : \(slider.maxValue)")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
//        print("didEndTouches : \(slider.minValue) : \(slider.maxValue)")
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        return ""
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue: CGFloat) -> String? {
        return ""
    }
}
