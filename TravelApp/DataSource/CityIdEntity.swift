//
//  HotelListEntity.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation

struct CityIdResponse: Decodable {
    var suggestions: [CityIdSuggestions]
}

struct CityIdSuggestions:Decodable {
    var entities: [CityId]
}

struct CityId:Decodable {
    var destinationId: String
}
