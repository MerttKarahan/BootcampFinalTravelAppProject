//
//  FlightListEntity.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation

struct FlightItemResponse: Decodable {
    
    var origin: String?
    var destination: String?
    var price: Int?
    var flightNumber : Int?
    var departureAt: String?
    var returnAt: String?
    
    // MARK: - Enumerations
    enum CodingKeys: String, CodingKey {
        case origin
        case destination
        case price
        case flightNumber = "flight_number"
        case departureAt = "departure_at"
        case returnAt = "return_at"
    }
}

