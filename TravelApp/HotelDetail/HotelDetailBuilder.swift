//
//  HotelDetailBuilder.swift
//  TravelApp
//
//  Created by Mert Karahan on 3.10.2022.
//

import Foundation

struct HotelDetailBuilder {
    
    static func hotelBuilder(hotelResponse: HotelResult) -> HotelDetailViewController {
        let hotelDeatilVM = HotelDetailViewModel(hotelResult: hotelResponse)
        let hotelDetailVC = HotelDetailViewController()
        let hotelDetailM = HotelDetailModel()
        hotelDetailVC.hotelDetailViewModel = hotelDeatilVM
        hotelDeatilVM.hotelDetailModel = hotelDetailM
        hotelDeatilVM.hotelDetailViewModelDelegate = hotelDetailVC
        return hotelDetailVC
    }
}
