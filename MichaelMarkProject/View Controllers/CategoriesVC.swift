//
//  CategoriesVC.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import UIKit
import SwiftyJSON
class CategoriesVC: UIViewController {
    //MARK: Variables
    var arr = [JSON]()
    var selectedIndex = -1
    //MARK: Outlets
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = -1
     
        guard let url = URL(string: API.genres) else { return }
        let params: [String:Any] = [
            "api_key":apiKey,
            "language":"en-US"
        ]
        ApiHelper.sharedInstance.getDetails(url: url, params: params) { [self] in
            let json = ApiHelper.sharedInstance.saveData.data
            for (_, value) in json {
                let arrDict = value.array ?? []
                arr = arrDict
            }
            tblView.reloadData()
        }
    }
}
//MARK: Extensions
extension CategoriesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesCell", for: indexPath) as! CategoriesTableViewCell
        let titleName = arr[indexPath.row]["name"].stringValue
        let id = arr[indexPath.row]["id"].int
        cell.lblTitle.text = titleName
        if indexPath.row == selectedIndex {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TappedListVC") as! TappedListVC
            vc.titleName = titleName
            vc.id = "\(id ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tblView.reloadData()
    }
    
}
