//
//  ListVCSort.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import UIKit
import SwiftyJSON
import Kingfisher
class ListVCSort: UIViewController {
        //MARK: Variables
        var arr = [JSON]()
        var selectedIndex = -1
        var heading = ""
        //MARK: Outlets
        @IBOutlet weak var tblView: UITableView!
        
    @IBOutlet weak var lblHeading: UILabel!
    //MARK: LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            selectedIndex = -1
            lblHeading.text = heading
        }
    //MARK: Actions
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    }
    //MARK: Extensions
    extension ListVCSort: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
            let title = arr[indexPath.row]["title"].stringValue
            let name = arr[indexPath.row]["name"].stringValue
            let imagePath = arr[indexPath.row]["poster_path"].stringValue
            let descriptionN = arr[indexPath.row]["overview"].stringValue
                cell.lblTitle.text = "\(name)\(title)"
            if indexPath.row == selectedIndex {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionVC
                vc.titleData = cell.lblTitle.text ?? ""
                vc.imgViewData = API.getImage+imagePath
                vc.descriptionData = descriptionN
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedIndex = indexPath.row
            tblView.reloadData()
        }
        
    }
