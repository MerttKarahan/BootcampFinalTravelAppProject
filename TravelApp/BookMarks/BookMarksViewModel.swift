//
//  BookMarksViewModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation
import CoreData

protocol BookMarksViewModelProtocol {
    func getFlightDataFromCoreData()
    func getHotelDataFromCoreData()
    func hotelItemAtIndex(index: Int) -> HotelResult
    func flightItemAtIndex(index: Int) -> FlightItemResponse
    var flightCoreDataList : [FlightItemResponse] {get}
    var hotelResultCoreDataList: [HotelResult] {get}
    var numberOfFlightItems: Int {get}
    var numberOfHotelItems: Int {get}
}

class BookMarksViewModel: BookMarksViewModelProtocol {
    
    var flightCoreDataList : [FlightItemResponse] = []
    var hotelResultCoreDataList: [HotelResult] = []
    
//    For determine number of flight items
    var numberOfFlightItems: Int {
        return flightCoreDataList.count
    }
    
//    For determine number of hotel items
    var numberOfHotelItems: Int {
        return hotelResultCoreDataList.count
    }
    
//    For determine flight items in index
    func flightItemAtIndex(index: Int) -> FlightItemResponse {
        return flightCoreDataList[index]
    }
    
    //    For determine hotel items in index
    func hotelItemAtIndex(index: Int) -> HotelResult {
        return hotelResultCoreDataList[index]
    }
    
    func getFlightDataFromCoreData() {
        self.flightCoreDataList = CoreDataManager.getFlights()
    }
    
    func getHotelDataFromCoreData() {
        self.hotelResultCoreDataList = CoreDataManager.getHotels()
    }
}
