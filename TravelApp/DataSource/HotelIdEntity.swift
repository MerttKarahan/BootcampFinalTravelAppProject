//
//  HotelIdEntity.swift
//  TravelApp
//
//  Created by Mert Karahan on 30.09.2022.
//

import Foundation

struct HotelResponse: Decodable {
    var data: HotelData
}

struct HotelData:Decodable {
    var body: HotelBody
}

struct HotelBody:Decodable {
    var searchResults: HotelSearchResults
}

struct HotelSearchResults: Decodable {
    var results: [HotelResult]
}

struct HotelResult: Decodable {
    var id : Int
    var name : String
    var starRating: Float
}
