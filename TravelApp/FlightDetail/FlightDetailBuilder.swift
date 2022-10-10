//
//  FlightDetailBuilder.swift
//  TravelApp
//
//  Created by Mert Karahan on 3.10.2022.
//

import Foundation

struct FlightDetailBuilder {
    static func flightBuilder(flightResponse: FlightItemResponse) -> FlightDetailViewController {
        let flightDetailVM = FlightDetailViewModel(flightResponse: flightResponse)
        let flightDetailVC = FlightDetailViewController()
        flightDetailVC.flightDetailViewModel = flightDetailVM
        
        return flightDetailVC
    }
}
