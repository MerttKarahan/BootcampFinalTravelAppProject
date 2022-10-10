//
//  HotelViewController.swift
//  TravelApp
//
//  Created by Mert Karahan on 3.10.2022.
//

import UIKit

class HotelDetailViewController: UIViewController {
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var hotelDetailFormattedScale: UILabel!
    @IBOutlet weak var hotelDetailFormattedRating: UILabel!
    @IBOutlet weak var hotelDetailInfo: UILabel!
    @IBOutlet weak var hotelDetailName: UILabel!
    @IBOutlet weak var hotelDetailCity: UILabel!
    @IBOutlet weak var hotelDetailContent: UILabel!
    @IBOutlet weak var hotelDetailAddress: UILabel!
    @IBOutlet weak var hotelDetailMapView: UIImageView!
    @IBOutlet weak var hotelDetailImage: UIImageView!
    @IBOutlet weak var hotelDetailBackButton: UIButton!
    @IBOutlet weak var hotelDetailAddBookMark: UIButton!
    
    var hotelDetailViewModel: HotelDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hotelDetailBackButtonUI()
        hotelDetailImageSettings()
        addBookMarkButtonUI()
        hotelDetailViewModel?.getDataFromHotelDetailModel()
        configureBookMarkTitle()        
    }
    
    @IBAction func hotelDetailAddBookmark(_ sender: Any) {
        hotelDetailViewModel?.userTappedAddButton()
        configureBookMarkTitle()
    }
    
    @IBAction func hotelDetailBackButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension HotelDetailViewController {
    
//    Configure all viewController features
    func hotelDetailConfigure() {
        let city = self.hotelDetailViewModel?.cityName ?? ""
        let country = self.hotelDetailViewModel?.countryName ?? ""
        
        hotelDetailFormattedScale.text =  self.hotelDetailViewModel?.formattedScale
        hotelDetailFormattedRating.text = self.hotelDetailViewModel?.formattedRating
        hotelDetailInfo.text = self.hotelDetailViewModel?.info
        hotelDetailName.text = self.hotelDetailViewModel?.name
        hotelDetailCity.text = "\(city) / \(country)"
        hotelDetailContent.text = self.hotelDetailViewModel?.content.joined(separator: ", ")
        hotelDetailAddress.text = self.hotelDetailViewModel?.fullAddress
        hotelDetailMapView.setImage(imageUrl: hotelDetailViewModel?.staticMapUrl ?? "")
        hotelDetailImage.image = UIImage(named: "hotelDetailView")
    }
    
//    For custom back button
    func hotelDetailBackButtonUI() {
        self.hotelDetailBackButton.setTitle("", for: .normal)
        let hotelDetailBackButton = UIImage(named: "backButton")
        self.hotelDetailBackButton.setImage(hotelDetailBackButton, for: .normal)
        self.backButtonView.layer.masksToBounds = true
        self.backButtonView.layer.cornerRadius = 7.0
    }
    
//    For image UI
    func hotelDetailImageSettings() {
        self.hotelDetailImage.layer.masksToBounds = true
        self.hotelDetailImage.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        self.hotelDetailImage.layer.cornerRadius = 20.0
    }
    
//    For determine CoreData operation (delete or add)
    func configureBookMarkTitle() {
        let title = "\((hotelDetailViewModel?.isHotelAddedBookMark ?? false) ? "Remove" : "Add") Bookmark"
        self.hotelDetailAddBookMark.setTitle(title, for: .normal)
    }
    
    func addBookMarkButtonUI() {
        self.hotelDetailAddBookMark.layer.masksToBounds = true
        self.hotelDetailAddBookMark.layer.cornerRadius = 8.0
    }
}

// Reload data. And return main thread
extension HotelDetailViewController: HotelDetailViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.hotelDetailConfigure()
        }
    }
}
