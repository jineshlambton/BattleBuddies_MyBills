//
//  HomeVC.swift
//  MyBills
//
//  Created by Vraj Patel on 17/07/22.
//

import UIKit

class HomeVC: BaseVC {
    
    @IBOutlet weak var imgSetting: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnSetting: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var imgFilter: UIImageView!
    @IBOutlet weak var btnFilter: UIButton!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewFloting: UIView!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnFloting: UIButton!
    
    var homeVm = HomeVM()
    var arrItem = [MyItemsInformation]()
    var arrItemSearched = [MyItemsInformation]()
    var appliedFilter : FilterParameter?
    var isSearchActive : Bool = false
    var isFromLogin = false
    var expiryVm : ExpiryVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeVm.delegate = self
        showProgress()
        setUpUI()
        NotificationCenter.default.addObserver(self, selector: #selector(updateList(notication: )), name: Notification.Name("updateItemList"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        isFromLogin = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if appliedFilter != nil {
            imgFilter.image = UIImage(named: "filterApplied")
        } else {
            imgFilter.image = UIImage(named: "filter")
        }
    }
    
    //MARK: - Custom methods
    
    func checkNoDataFound() {
        lblNoData.setLBL(text: "LBL_NO_DATA_FOUND".localizedLanguage(), font: .LBL_SUB_TITLE, textcolor: .black)
        if isSearchActive {
            if arrItemSearched.count == 0 {
                tblView.isHidden = true
                lblNoData.isHidden = false
            } else {
                tblView.isHidden = false
                lblNoData.isHidden = true
            }
        } else {
            if arrItem.count == 0 {
                tblView.isHidden = true
                lblNoData.isHidden = false
            } else {
                tblView.isHidden = false
                lblNoData.isHidden = true
            }
        }
    }
    
    @objc func updateList(notication : Notification) {
        homeVm.getItems()
    }
    
    private func checkExpiryAlert() {
        if isFromLogin {
            expiryVm = ExpiryVM()
            let arrItems = expiryVm?.currentWeekExpiryItems()
            if arrItems!.count > 0 {
                let objExpiryAlertVC = ExpiryAlertVC(nibName: "ExpiryAlertVC", bundle: nil)
                self.navigationController?.pushViewController(objExpiryAlertVC, animated: true)
            }
        }
    }
    
    private func manageCategoryForNewUser() {
        if MyFirebaseDataStore.instace.arrCategory.count == 0 {
            let objCategory = MyFirebaseCategory()
            objCategory.name = "Personal"
            objCategory.uId = MyUserDefault.instace.getLoggedInUser() ?? ""
            MyFirebaseDataStore.instace.addCategory(category: objCategory)
        }
    }
    
    private func setUpUI() {
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_HOME".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        btnFilter.setTitle("", for: .normal)
        btnFloting.setTitle("", for: .normal)
        btnSetting.setTitle("", for: .normal)
        searchBar.backgroundImage = UIImage()
        
        searchBar.searchTextField.placeholder = "Search your bill here.."
        tblView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        searchBar.delegate = self
    }

    //MARK: - Button tap methods
    
    @IBAction func btnSettingTapped(_ sender: Any) {
        let objSettingVC = SettingsVC(nibName: "SettingsVC", bundle: nil)
        self.navigationController?.pushViewController(objSettingVC, animated: true)
    }
    
    @IBAction func btnFilterTapped(_ sender: Any) {
        let objFilterVC = FilterVC(nibName: "FilterVC", bundle: nil)
        objFilterVC.delegate = self
        objFilterVC.objFilter = appliedFilter
        self.navigationController?.pushViewController(objFilterVC, animated: true)
    }
    
    @IBAction func btnFlotingTapped(_ sender: Any) {
        let objAddItemVC = AddItemVC(nibName: "AddItemVC", bundle: nil)
        objAddItemVC.delegate = self
        self.navigationController?.pushViewController(objAddItemVC, animated: true)
    }
    
}

extension HomeVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? arrItemSearched.count : arrItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.selectionStyle = .none
        cell.setUpUI()
        cell.setData(data: isSearchActive ? arrItemSearched[indexPath.row] : arrItem[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objHomeDetailVC = HomeDetailVC(nibName: "HomeDetailVC", bundle: nil)
        objHomeDetailVC.objMyItemInfo = isSearchActive ? arrItemSearched[indexPath.row] : arrItem[indexPath.row]
        objHomeDetailVC.delegate = self
        self.navigationController?.pushViewController(objHomeDetailVC, animated: true)
    }
    
}

extension HomeVC : HomeVMDelegate {
    func itemSynced(arr: [MyItemsInformation]) {
        arrItem = arr
        arrItemSearched = arr
        checkNoDataFound()
        hideProgress()
        checkExpiryAlert()
        self.tblView.reloadData()
    }
    
    func itemFiltered(arr: [MyItemsInformation]) {
        arrItem.removeAll()
        arrItem = arr
        checkNoDataFound()
        self.tblView.reloadData()
    }
    
    func categorySynced() {
        manageCategoryForNewUser()
        self.tblView.reloadData()
    }
}

extension HomeVC : FilterVCDelegate {
    func appliedFilter(filter: FilterParameter?) {
        if filter != nil {
            appliedFilter = filter
            checkNoDataFound()
            homeVm.filteredItems(filter: filter!)
        } else {
            arrItem = MyFirebaseDataStore.instace.arrItem
            arrItemSearched = MyFirebaseDataStore.instace.arrItem
            appliedFilter = nil
            checkNoDataFound()
            tblView.reloadData()
        }
    }
}

extension HomeVC : HomeDetailVCDelegate {
    func deletedItemSuccessfully() {
        appliedFilter = nil
        homeVm.getItems()
    }
}

extension HomeVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = true
//        arrItemSearched = arrItem.filter{ $0.name?.rangeOfCharacter(from: CharacterSet(charactersIn: searchText)) != nil }
        
        arrItemSearched = arrItem.filter { $0.name?.range(of: searchText) != nil}
        checkNoDataFound()
        tblView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        isSearchActive = true
        checkNoDataFound()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        isSearchActive = false
        checkNoDataFound()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        self.searchBar.text = nil
        self.searchBar.resignFirstResponder()
        tblView.resignFirstResponder()
        self.searchBar.showsCancelButton = false
        checkNoDataFound()
        tblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        checkNoDataFound()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    
}

extension HomeVC : AddItemVCDelegate {
    func newItemAdded() {
        homeVm.getItems()
    }
}
