//
//  SearchVC.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import UIKit
import SwiftyJSON
import Kingfisher
class SearchVC: UIViewController {
    var arr = [JSON]()
    var selectedIndex = -1
    //MARK: Outlets
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchField.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedIndex = -1
        tblView.isHidden = false
        if searchField.text?.isEmpty == true {
            tblView.isHidden = true
        }
    }

}
//MARK: Extensions
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        let title = arr[indexPath.row]["title"].stringValue
        let name = arr[indexPath.row]["name"].stringValue
        let imagePath = arr[indexPath.row]["poster_path"].stringValue
        let imgUrl = URL(string: API.getImage+imagePath)
        let descriptionN = arr[indexPath.row]["overview"].stringValue
        let processor = DownsamplingImageProcessor(size: cell.imgView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.imgView.kf.indicatorType = .activity
        cell.imgView.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
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
extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let url = URL(string: API.searchMovies) else { return }
        let param: [String:Any] = [
            "api_key":apiKey,
            "query":"\(searchBar.text ?? "")"
        ]
        if searchBar.text?.isEmpty == false{
            tblView.isHidden = false
            ApiHelper.sharedInstance.getDetails(url: url, params: param) { [self] in
                let json = ApiHelper.sharedInstance.saveData.data
                arr = json["results"].arrayValue
                if arr.isEmpty == true {
                    tblView.isHidden = true
                }else {
                    tblView.isHidden = false
                }
                tblView.reloadData()
            }
        }else {
            tblView.isHidden = true
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchField.resignFirstResponder()
    }
}
