//
//  ListCollectionViewCell.swift
//  TravelApp
//
//  Created by Mert Karahan on 30.09.2022.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCellView()
    }

    func configure(response: Decodable) {
        if let flightResponse = response as? FlightItemResponse {
            self.label1.text = flightResponse.origin
            self.label2.text = flightResponse.destination
            self.label3.text = flightResponse.departureAt?.convertToReadable
            self.image.image = UIImage(named: "listViewAirPlane")
        } else if let hotelResponse = response as? HotelResult {
            self.label1.text = hotelResponse.name
            self.label2.isHidden = true
            self.view.isHidden = true
            self.label3.text = hotelResponse.starRating.description
            self.image.image = UIImage(named: "listViewHotel")
        }
    }
    
    func setCellView() {
        image.layer.cornerRadius = 10.0
        image.layer.masksToBounds = true
        
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
    }
    
    
}
