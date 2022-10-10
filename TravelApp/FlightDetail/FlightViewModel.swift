//
//  FlightViewModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 3.10.2022.
//

import Foundation
import UIKit

protocol FlightDetailViewModelProtocol {
    var flightNumber: Int {get}
    var flightPrice: Int {get}
    var flightOrigin: String {get}
    var flightDestination: String {get}
    var flightDepartureAt: String {get}
    var flightReturnAt: String {get}
    var isFlightAddedBookMark: Bool {get}
    func userTappedAddButton()
}

class FlightDetailViewModel: FlightDetailViewModelProtocol {
    
    var flightResponse: FlightItemResponse
    
    init(flightResponse : FlightItemResponse) {
        self.flightResponse = flightResponse
    }
    
    var flightNumber: Int {
        return flightResponse.flightNumber ?? 0
    }
    
    var flightPrice: Int {
        return flightResponse.price ?? 0
    }
    
    var flightOrigin: String {
        return flightResponse.origin ?? ""
    }
    
    var flightDestination: String {
        return flightResponse.destination ?? ""
    }
    
    var flightDepartureAt: String {
        return flightResponse.departureAt ?? ""
    }
    
    var flightReturnAt: String {
        return flightResponse.returnAt ?? ""
    }
    
    //    Return bool value for determine CoreData operation
    var isFlightAddedBookMark: Bool {
        CoreDataManager.coreDataFlightCheck(flightResponse: flightResponse)
    }
    
    //    If isFlightAddBookMarks is true, thats mean when button tapped we should delete item from CoreData. Otherwise add item to CoreData
    func userTappedAddButton() {
        if isFlightAddedBookMark {
            CoreDataManager.deleteFlight(flightResponse: flightResponse)
        } else {
            CoreDataManager.saveFlight(flight: flightResponse)
        }
    }
    
}
