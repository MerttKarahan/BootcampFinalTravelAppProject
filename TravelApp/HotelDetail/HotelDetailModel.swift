//
//  HotelModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 3.10.2022.
//

import Foundation

protocol HotelDetailModelProtocol {
    var hotelDetailBody: HotelDetailBody? {get}
    func getHotelDetails(hotelId: Int, finishGetHotelDetails: @escaping ()->Void)
}

class HotelDetailModel: HotelDetailModelProtocol {
    
    var hotelDetailBody: HotelDetailBody?
    
//    For get hotel detail from api
    func getHotelDetails(hotelId: Int, finishGetHotelDetails: @escaping ()->Void) {
        DataSource.sharedInstance.getHotelDetails(hotelId: hotelId) { hotelDetailResponse in
            switch hotelDetailResponse {
            case.success(let successHotelDetailResponse):
                self.hotelDetailBody = successHotelDetailResponse.data.body
                finishGetHotelDetails()
            case.failure(let unsuccessfulHotelDetailResponse):
                print("\(unsuccessfulHotelDetailResponse)")
            }
        }
    }
}
