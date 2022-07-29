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
    @IBOutlet weak var btnFloting: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        syncCategory()
        syncItems()
    }
    
    //MARK: - Custom methods
    
    func syncCategory() {
        showProgress()
        MyFirebaseDataStore.instace.delegate = self
        MyFirebaseDataStore.instace.getCategories()
    }
    
    func syncItems() {
        showProgress()
        MyFirebaseDataStore.instace.delegate = self
        MyFirebaseDataStore.instace.getItems()
    }
    
    func setUpUI() {
        viewNavBar.backgroundColor = MyColor.theme.color
        lblTitle.setLBL(text: "NAV_TITLE_HOME".localizedLanguage(), font: .LBL_TITLE, textcolor: .white)
        btnFilter.setTitle("", for: .normal)
        btnFloting.setTitle("", for: .normal)
        btnSetting.setTitle("", for: .normal)
        searchBar.backgroundImage = UIImage()
        
        tblView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }

    //MARK: - Button tap methods
    
    @IBAction func btnSettingTapped(_ sender: Any) {
        let objSettingVC = SettingsVC(nibName: "SettingsVC", bundle: nil)
        self.navigationController?.pushViewController(objSettingVC, animated: true)
    }
    
    @IBAction func btnFilterTapped(_ sender: Any) {
        let objFilterVC = FilterVC(nibName: "FilterVC", bundle: nil)
        self.navigationController?.pushViewController(objFilterVC, animated: true)
    }
    
    @IBAction func btnFlotingTapped(_ sender: Any) {
        let objAddItemVC = AddItemVC(nibName: "AddItemVC", bundle: nil)
        self.navigationController?.pushViewController(objAddItemVC, animated: true)
    }
    
}

extension HomeVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyFirebaseDataStore.instace.arrItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeCell
        cell.selectionStyle = .none
        cell.setUpUI()
        cell.setData(data: MyFirebaseDataStore.instace.arrItem[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objHomeDetailVC = HomeDetailVC(nibName: "HomeDetailVC", bundle: nil)
        self.navigationController?.pushViewController(objHomeDetailVC, animated: true)
    }
    
}

extension HomeVC : MyFirebaseDataStoreDelegate {
    func categorySynced() {
        hideProgress()
    }
    
    func itemsSynced() {
        hideProgress()
        tblView.reloadData()
    }
}
