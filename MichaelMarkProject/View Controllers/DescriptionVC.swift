//
//  DescriptionVC.swift
//  MichaelMarkProject
//
//  Created by mac on 16/03/23.
//

import UIKit
import Kingfisher
class DescriptionVC: UIViewController, UIScrollViewDelegate {
    var titleData = ""
    var descriptionData = ""
    var imgViewData = ""
    //MARK: Outlets
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var scrlView: UIScrollView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrlView.delegate = self
        scrlView.minimumZoomScale = 1.0
        scrlView.maximumZoomScale = 6.0
        
    }
    override func viewWillAppear(_ animated: Bool) {
        lblDescription.text = descriptionData
        lblTitle.text = titleData
        imgView.kf.setImage(with: URL(string: imgViewData))
    }

   //MARK: Actions
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: Functions
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imgView
    }
}
//MARK: Extensions

