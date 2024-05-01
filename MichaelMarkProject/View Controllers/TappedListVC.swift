//
//  TappedListVC.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import UIKit
import SwiftyJSON
import Kingfisher
class TappedListVC: UIViewController {
    var selectedIndex = -1
    var titleName = ""
    var id = ""
    var data = [JSON]()
   
    //MARK: Outlets
    @IBOutlet weak var collView: UICollectionView!
    
    @IBOutlet weak var lblTitle: UILabel!
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = titleName
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedIndex = -1
        let param = [
            "api_key":apiKey,
            "with_genres":id
        ]
        guard let url = URL(string: API.genreSelection) else { return }
        ApiHelper.sharedInstance.getDetails(url: url, params: param) { [self] in
            let json = ApiHelper.sharedInstance.saveData.data
            print(json)
            let arr = json["results"].arrayValue
            data = arr
            collView.reloadData()
        }
    }
    //MARK: Actions
     @IBAction func btnBack(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
     }

}
//MARK: Extensions
extension TappedListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TapCell", for: indexPath) as! TapListCollectionViewCell
        let imagePath = data[indexPath.row]["poster_path"].stringValue
        let imgUrl = URL(string: API.getImage+imagePath)
        let title = data[indexPath.row]["title"].stringValue
        let name = data[indexPath.row]["name"].stringValue
        let description = data[indexPath.row]["overview"].stringValue
        let processor = DownsamplingImageProcessor(size: cell.imgView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.imgView.kf.indicatorType = .activity
        cell.imgView.kf.setImage(with: imgUrl,
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
        cell.imgView.kf.setImage(with: imgUrl)
        cell.lblTitle.text = "\(name)\(title)"
        if indexPath.row == selectedIndex {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionVC") as! DescriptionVC
            vc.titleData = cell.lblTitle.text ?? ""
            vc.imgViewData = API.getImage+imagePath
            vc.descriptionData = description
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

extension TappedListVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
