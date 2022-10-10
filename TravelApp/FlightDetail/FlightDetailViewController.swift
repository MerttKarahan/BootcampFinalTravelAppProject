//
//  FlightViewController.swift
//  TravelApp
//
//  Created by Mert Karahan on 3.10.2022.
//

import UIKit

class FlightDetailViewController: UIViewController {
    
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var flightDetailBackButton: UIButton!
    @IBOutlet weak var flightImage: UIImageView!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var flightPriceLabel: UILabel!
    @IBOutlet weak var flightOriginLabel: UILabel!
    @IBOutlet weak var flightDestinationLabel: UILabel!
    @IBOutlet weak var flightDepartureAtLabel: UILabel!
    @IBOutlet weak var flightReturnAtLabel: UILabel!
    @IBOutlet weak var addBookmarkButton: UIButton!
    
    @IBOutlet weak var flightAddBookMarkButton: UIButton!
    
    var flightDetailViewModel: FlightDetailViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        flightDetailConfigure()
        flightDetailBackButtonUI()
        flightDetailImageSettings()
        configureBookMarkTitle()
        addBookMarkButtonUI()

    }
    
    @IBAction func addBookMarkButtonClicked(_ sender: Any) {
        flightDetailViewModel?.userTappedAddButton()
        configureBookMarkTitle()
    }
    
    @IBAction func flightDetailBackButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension FlightDetailViewController {
    
    //    Configure all viewController features
    func flightDetailConfigure() {
        self.flightImage.image = UIImage(named: "flightDetailView")
        self.flightNumberLabel.text = "Flight Number: \(flightDetailViewModel?.flightNumber.description ?? "")"
        self.flightPriceLabel.text =  "\(flightDetailViewModel?.flightPrice.description ?? "") TL"
        self.flightOriginLabel.text = flightDetailViewModel?.flightOrigin
        self.flightDestinationLabel.text = flightDetailViewModel?.flightDestination
        
        self.flightDepartureAtLabel.text = flightDetailViewModel?.flightDepartureAt.convertToReadable
        self.flightReturnAtLabel.text = flightDetailViewModel?.flightReturnAt.convertToReadable
    }
    
    //    For custom back button
    func flightDetailBackButtonUI() {
        self.flightDetailBackButton.setTitle("", for: .normal)
        let flightDetailBackButton = UIImage(named: "backButton")
        self.flightDetailBackButton.setImage(flightDetailBackButton?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.backButtonView.layer.masksToBounds = true
        self.backButtonView.layer.cornerRadius = 7.0
    }
    
    //    For image UI
    func flightDetailImageSettings() {
        flightImage.layer.masksToBounds = true
        self.flightImage.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        self.flightImage.layer.cornerRadius = 20.0
        
    }
    
    //    For determine button title for CoreData operation (delete or add)
    func configureBookMarkTitle() {
        let title = "\((flightDetailViewModel?.isFlightAddedBookMark ?? false) ? "Remove" : "Add") Bookmark"
        self.addBookmarkButton.setTitle(title, for: .normal)
        
    }
    
    func addBookMarkButtonUI() {
        self.addBookmarkButton.layer.masksToBounds = true
        self.addBookmarkButton.layer.cornerRadius = 8.0
    }
}

