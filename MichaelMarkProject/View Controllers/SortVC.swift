//
//  SortVC.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import UIKit

class SortVC: UIViewController {
    var arr = [
        "Trending Movies", "Now Playing Movies", "Popular Movies", "Upcoming Movies"
    ]
    var selectedIndex = -1
    //MARK: Outlets
    @IBOutlet weak var tblView: UITableView!
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
//MARK: Extensions
extension SortVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath) as! SortTableViewCell
        cell.lblTitle.text = arr[indexPath.row]
        if selectedIndex == indexPath.row {
            if selectedIndex == 0 {
                guard let url = URL(string: API.trendingMovies) else { return cell }
                let param = [
                    "api_key":apiKey
                ]
                ApiHelper.sharedInstance.getDetails(url: url, params: param) { [self] in
                    let json = ApiHelper.sharedInstance.saveData.data
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListVCSort") as! ListVCSort
                    let results = json["results"].arrayValue
                    vc.arr = results
                    vc.heading = arr[indexPath.row]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else if selectedIndex == 1 {
                guard let url = URL(string: API.nowPlaying) else { return cell }
                let param = [
                    "api_key":apiKey
                ]
                ApiHelper.sharedInstance.getDetails(url: url, params: param) { [self] in
                    let json = ApiHelper.sharedInstance.saveData.data
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListVCSort") as! ListVCSort
                    let results = json["results"].arrayValue
                    vc.arr = results
                    vc.heading = arr[indexPath.row]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else if selectedIndex == 2 {
                guard let url = URL(string: API.popularMovies) else { return cell }
                let param = [
                    "api_key":apiKey
                ]
                ApiHelper.sharedInstance.getDetails(url: url, params: param) { [self] in
                    let json = ApiHelper.sharedInstance.saveData.data
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListVCSort") as! ListVCSort
                    let results = json["results"].arrayValue
                    vc.arr = results
                    vc.heading = arr[indexPath.row]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else if selectedIndex == 3 {
                guard let url = URL(string: API.upcomingMovies) else { return cell }
                let param = [
                    "api_key":apiKey
                ]
                ApiHelper.sharedInstance.getDetails(url: url, params: param) { [self] in
                    let json = ApiHelper.sharedInstance.saveData.data
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListVCSort") as! ListVCSort
                    let results = json["results"].arrayValue
                    vc.arr = results
                    vc.heading = arr[indexPath.row]
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tblView.reloadData()
    }
    
}
