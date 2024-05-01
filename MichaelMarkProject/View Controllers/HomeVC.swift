//
//  ViewController.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import UIKit
import SwiftyJSON
import Kingfisher
var apiKey = "b84aec0e45944b499ef12000744503ed"
class HomeVC: UIViewController {
    
var arr = [JSON]()
    var selectedIndex = -1
//MARK: Outlets
    @IBOutlet weak var collView: UICollectionView!
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedIndex = -1
        guard let url = URL(string: API.trendingMovies) else { return }
        let params: [String:Any] = [
            "api_key":apiKey
        ]
        ApiHelper.sharedInstance.getDetails(url: url, params: params) { [self] in
            let json = ApiHelper.sharedInstance.saveData.data
            print(json)
            let results = json["results"].arrayValue
            arr = results
            collView.reloadData()
        }
    }
}
//MARK: Extensions
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collView.reloadData()
    }
    
}
// MARK: - UICollectionViewDelegateFlowLayout

extension HomeVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width/2, height: size.height/2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
