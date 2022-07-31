//
//  FilterVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit
import SwiftyMenu
import RangeSeekSlider
import DropDown

@objc protocol FilterVCDelegate : NSObjectProtocol {
    @objc optional func appliedFilter(filter : FilterParameter?)
}

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
    
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var priceRange: RangeSeekSlider!
    
    @IBOutlet weak var lblMinValue: UILabel!
    @IBOutlet weak var lblMaxValue: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    weak var delegate : FilterVCDelegate?
    
    var purchaseDate : Date?
    var expiryDate : Date?
    var minPrice : Int?
    var maxPrice : Int?
    private let dropDown = DropDown()
    private var arrCategoryTitle : [String] = [String]()
    private var selectedCategoryId : String?
    private var arrCategoryId : [String] = [String]()
    
    var objFilter : FilterParameter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCategoryAPICall()
        setUpUI()
        setData()
    }
    
    //MARK: - Custom methods
    
    func setData() {
        if objFilter != nil {
            if let catId = objFilter?.categoryId {
                let name = MyFirebaseDataStore.instace.getCategoryName(id: catId)
                lblCategory.text = name
                selectedCategoryId = catId
            }
            if let pDate = objFilter?.purchaseDate {
                purchaseDate = pDate
                lblDate1.setLBL(text: "Purchase Date : \(pDate.dateString())", font: .LBL_SUB_TITLE, textcolor: .black)
            }
            if let eDate = objFilter?.expiryDate {
                expiryDate = eDate
                lblDate2.setLBL(text: "Expiry Date : \(eDate.dateString())", font: .LBL_SUB_TITLE, textcolor: .black)
            }
            if let mnPrice = objFilter?.minPrice {
                minPrice = Int(mnPrice)
            }
            if let mxPrice = objFilter?.maxPrice {
                maxPrice = Int(mxPrice)
            }
        }
    }
    
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
        lblCategory.setLBL(text: "Select Category : ", font: .LBL_SUB_TITLE, textcolor: .black)
        btnDate1.setTitle("", for: .normal)
        btnDate2.setTitle("", for: .normal)
        btnCategory.setTitle("", for: .normal)
        curveView(view: viewDate1)
        curveView(view: viewDate2)
        curveView(view: viewCategory)
        
        setUpDropdown()
        DispatchQueue.main.async {
            self.setUpPriceRange()
        }
        
    }
    
    private func getCategoryAPICall() {
        showProgress()
        MyFirebaseDataStore.instace.delegate = self
        MyFirebaseDataStore.instace.getCategories()
    }
    
    func curveView(view : UIView) {
        view.layer.borderColor = MyColor.textFieldBorder.color.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 10.0
    }
    
    private func sortCategoryTitle() {
        arrCategoryTitle.removeAll()
        arrCategoryTitle = MyFirebaseDataStore.instace.arrCategory.map { $0.name! }
        arrCategoryId = MyFirebaseDataStore.instace.arrCategory.map { $0.documentID! }
        dropDown.dataSource = arrCategoryTitle
    }
    
    private func showDatePicker(date: Date?, type : DatePickerType) {
        var title = ""
        var minDate = Date()
        if type == .purchaseDate {
            title = "Select purchase date".localizedLanguage()
            minDate = Util.fromDate(year: 1900, month: 1, day: 1)
        } else if type == .expiryDate {
            title = "Select expiry date".localizedLanguage()
            minDate = Date()
        }
        let alert = UIAlertController(title: Util.applicationName, message: title, preferredStyle: .alert)
        
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: minDate, maximumDate: date) { [self] date in
            print("Date : \(date)")
            if type == .purchaseDate {
                purchaseDate = date
                lblDate1.setLBL(text: "Purchase Date : \(date.dateString())", font: .LBL_SUB_TITLE, textcolor: .black)
            } else if type == .expiryDate {
                expiryDate = date
                lblDate2.setLBL(text: "Expiry Date : \(date.dateString())", font: .LBL_SUB_TITLE, textcolor: .black)
            }
        }
        alert.addAction(title: "OK_BTN_ON_ALERT".localizedLanguage(), color: .black, style: .cancel)
        self.present(alert, animated: true, completion: nil)
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
        dropDown.anchorView = viewCategory
        dropDown.dataSource = arrCategoryTitle
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            lblCategory.text = item
            selectedCategoryId = arrCategoryId[index]
        }
    }
    
    private func setUpPriceRange() {
        let mn = MyFirebaseDataStore.instace.minPriceValue()
        let mx = MyFirebaseDataStore.instace.maxPriceValue()
        
        priceRange.delegate = self
        priceRange.minValue = mn
        priceRange.maxValue = mx
        priceRange.selectedMinValue = minPrice == nil ? mn + ((mn * 20) / 100) : CGFloat(minPrice!)
        priceRange.selectedMaxValue = maxPrice == nil ? mx - ((mx * 20 / 100)) : CGFloat(maxPrice!)
        priceRange.hideLabels = false
        priceRange.labelsFixed = false
        priceRange.minLabelFont = .LBL_TITLE
        priceRange.maxLabelFont = .LBL_TITLE
        priceRange.disableRange = false
        lblMinValue.text = minPrice == nil ? "Min : -" : "Min : \(minPrice!)"
        lblMaxValue.text = maxPrice == nil ? "Max : -" : "Max : \(maxPrice!)"
    }
    
    func validation() -> Bool {
        if purchaseDate == nil && expiryDate == nil && selectedCategoryId == nil && minPrice == nil && maxPrice == nil {
            self.showAlert(msg: "Please select filter option")
            return false
        } else {
            return true
        }
    }
    
    //MARK: - Button tap methods
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if validation() {
            objFilter = FilterParameter()
            objFilter?.purchaseDate = purchaseDate
            objFilter?.expiryDate = expiryDate
            objFilter?.categoryId = selectedCategoryId
            objFilter?.maxPrice = maxPrice == nil ? nil : String(maxPrice!)
            objFilter?.minPrice = minPrice == nil ? nil : String(minPrice!)
            self.delegate?.appliedFilter?(filter: objFilter)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnResetTapped(_ sender: Any) {
        self.delegate?.appliedFilter?(filter: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDatePicker1Tapped(_ sender: Any) {
        showDatePicker(date: Date(), type: .purchaseDate)
    }
    
    @IBAction func btnDatePicker2Tapped(_ sender: Any) {
        showDatePicker(date: Util.fromDate(year: 2100, month: 1, day: 1), type: .expiryDate)
    }
    
    @IBAction func btnCategoryTapped(_ sender: Any) {
        dropDown.show()
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
        self.minPrice = Int(minValue)
        self.maxPrice = Int(maxValue)
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

extension FilterVC : MyFirebaseDataStoreDelegate {
    func categorySynced() {
        hideProgress()
        sortCategoryTitle()
    }
}
