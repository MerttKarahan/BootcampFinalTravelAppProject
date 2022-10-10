//
//  NewsDetailViewController.swift
//  TravelApp
//
//  Created by Mert Karahan on 10.10.2022.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsPublishedAt: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsContent: UILabel!
    var newsDetailViewModel: NewsDetailViewProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        newsImageUI()
        backButtonUI()
       
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
//    Configure for all fetaures of viewController
    func configure() {
        self.newsImage.setImage(imageUrl: newsDetailViewModel?.image ?? "")
        self.newsPublishedAt.text = newsDetailViewModel?.publishedAt
        self.newsTitle.text = newsDetailViewModel?.title
        self.newsDescription.text = newsDetailViewModel?.description
        self.newsContent.text = newsDetailViewModel?.content
    }


}

extension NewsDetailViewController {
//    For set image UI
    func newsImageUI() {
        self.newsImage.layer.masksToBounds = true
        self.newsImage.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        self.newsImage.layer.cornerRadius = 32.0
    }
    
//    For custom back button UI
    func backButtonUI() {
        self.backButton.setTitle("", for: .normal)
        let backButton = UIImage(named: "backButton")
        self.backButton.setImage(backButton, for: .normal)
        self.backButtonView.layer.masksToBounds = true
        self.backButtonView.layer.cornerRadius = 7.0
    }
}
