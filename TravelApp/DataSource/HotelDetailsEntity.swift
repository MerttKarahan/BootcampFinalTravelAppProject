//
//  HotelDetailsEntity.swift
//  TravelApp
//
//  Created by Mert Karahan on 30.09.2022.
//

import Foundation

struct HotelDetailResponse: Decodable {
    var data: HotelDetailData
}

struct HotelDetailData:Decodable {
    var body: HotelDetailBody
}

struct HotelDetailBody: Decodable {
    var overview: HotelDetailOverview
    var hotelWelcomeRewards: HotelDetailHotelWelcomeRewards
    var propertyDescription: HotelDetailPropertyDescription
    var guestReviews : HotelDetailGuestReviews
}

struct HotelDetailOverview:Decodable {
    var overviewSections : [HotelDetailOverviewSections]
}

struct HotelDetailOverviewSections:Decodable{
    var content : [String]?
}

struct HotelDetailHotelWelcomeRewards:Decodable {
    var info : String?
}

struct HotelDetailPropertyDescription:Decodable {
    var address: HotelDetailPropertyAddress
    var mapWidget : StaticMapWidget
    var name: String?
}

struct HotelDetailPropertyAddress:Decodable {
    var cityName : String?
    var countryName : String?
    var fullAddress: String?
}

struct StaticMapWidget:Decodable {
    var staticMapUrl : String?
}

struct HotelDetailGuestReviews:Decodable {
    var brands: BrandsDetail
}

struct BrandsDetail:Decodable {
    var formattedScale: String?
    var formattedRating: String?
}
