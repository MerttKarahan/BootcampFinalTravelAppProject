//
//  HotelViewModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 3.10.2022.
//

import Foundation

protocol HotelDetailViewModelProtocol {
    func getDataFromHotelDetailModel()
    var content : [String] {get}
    var info : String {get}
    var name: String {get}
    var cityName: String {get}
    var countryName: String {get}
    var fullAddress: String {get}
    var staticMapUrl : String {get}
    var formattedScale : String {get}
    var formattedRating : String {get}
    var isHotelAddedBookMark: Bool {get}
    var hotelDetailViewModelDelegate: HotelDetailViewModelDelegate? {get set}
    func userTappedAddButton()
}

protocol HotelDetailViewModelDelegate: AnyObject {
    func reloadData()
}

class HotelDetailViewModel: HotelDetailViewModelProtocol {
    
    weak var hotelDetailViewModelDelegate: HotelDetailViewModelDelegate?

    
    var hotelResult : HotelResult
    
    var hotelDetailModel : HotelDetailModelProtocol = HotelDetailModel()
    
    init(hotelResult:HotelResult) {
        self.hotelResult = hotelResult
        print("merttest: \(hotelResult.id)")
    }
    
    var content : [String] {
        return hotelDetailModel.hotelDetailBody?.overview.overviewSections.first?.content ?? [""]
    }
    
    var info : String {
        return hotelDetailModel.hotelDetailBody?.hotelWelcomeRewards.info ?? ""
    }
    
    var name: String {
        return hotelDetailModel.hotelDetailBody?.propertyDescription.name ?? ""
    }
    
    var cityName: String {
        return hotelDetailModel.hotelDetailBody?.propertyDescription.address.cityName ?? ""
    }
    
    var countryName: String {
        return hotelDetailModel.hotelDetailBody?.propertyDescription.address.countryName ?? ""
    }
    
    var fullAddress: String {
        return hotelDetailModel.hotelDetailBody?.propertyDescription.address.fullAddress ?? ""
    }
    
    var staticMapUrl : String {
        return hotelDetailModel.hotelDetailBody?.propertyDescription.mapWidget.staticMapUrl ?? ""
    }
    
    var formattedScale : String {
        return hotelDetailModel.hotelDetailBody?.guestReviews.brands.formattedScale ?? ""
    }
    
    var formattedRating : String {
        return hotelDetailModel.hotelDetailBody?.guestReviews.brands.formattedRating ?? ""
    }
    
//    Return bool value for determine CoreData operation
    var isHotelAddedBookMark: Bool {
        CoreDataManager.coreDataHotelCheck(hotelId: hotelResult.id)
    }
    
//    For get hotel detail response from model
    func getDataFromHotelDetailModel() {
        hotelDetailModel.getHotelDetails(hotelId: hotelResult.id) {
            self.hotelDetailViewModelDelegate?.reloadData()
        }
    }
    
//    If isHotelAddBookMarks is true, thats mean when button tapped we should delete item from CoreData. Otherwise add item to CoreData
    func userTappedAddButton() {
        if isHotelAddedBookMark {
            CoreDataManager.deleteHotel(hotelId: hotelResult.id)
        } else {
            CoreDataManager.saveHotel(hotel: hotelResult)
        }
    }
}
