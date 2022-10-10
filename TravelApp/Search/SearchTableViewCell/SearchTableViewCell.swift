//
//  SearchTableViewCell.swift
//  TravelApp
//
//  Created by Mert Karahan on 9.10.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellView()
    }

    func configure(response: Decodable) {
        if let flightResponse = response as? FlightItemResponse {
            self.label1.text = flightResponse.origin
            self.label2.text = flightResponse.destination
            self.label3.text = flightResponse.departureAt
            self.searchImage.image = UIImage(named: "listViewAirPlane")
        } else if let hotelResponse = response as? HotelResult {
            self.label1.text = hotelResponse.name
            self.label2.isHidden = true
            self.view.isHidden = true
            self.label3.text = hotelResponse.starRating.description
            self.searchImage.image = UIImage(named: "listViewHotel")
        }
    }
    
    func setCellView() {
        searchImage.layer.cornerRadius = 10.0
        searchImage.layer.masksToBounds = true
        
        shadowView.layer.cornerRadius = 10.0
        shadowView.layer.masksToBounds = true
    }

}
