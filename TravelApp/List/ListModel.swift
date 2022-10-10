//
//  ListModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 30.09.2022.
//

import Foundation

protocol ListModelProtocol {
    var hotelEntity: HotelResponse? {get}
    var flightEntity: [FlightItemResponse]? {get}
    func getHotelList(finishGetHotelList: @escaping ()->(Void))
    func getFlightList(finishGetFlightList : @escaping ()->Void)
}

class ListModel: ListModelProtocol {
    
    private var cityIdResponse: CityIdResponse?
    private var hotelPage : Int = 1

    var hotelEntity: HotelResponse?
    var flightEntity: [FlightItemResponse]?
    
//    If city id is exist, don't need request (thats mean user do pagination). However if we don't have city id, request for it
    private func getCityIdFromCache(finishGetId: @escaping (String)->Void) {
        if let cityIdResponse = cityIdResponse {
            finishGetId(cityIdResponse.suggestions.first?.entities.first?.destinationId ?? "1341107")
        } else {
            DataSource.sharedInstance.getHotelSearch { cityIdResponse in
                switch cityIdResponse{
                case.success(let successCityIdResponse):
                    self.cityIdResponse = successCityIdResponse
                    finishGetId(successCityIdResponse.suggestions.first?.entities.first?.destinationId ?? "1341107")
                case.failure(let unsuccessfulCityIdResponse):
                    print("error \(unsuccessfulCityIdResponse.localizedDescription)")
                }
            }
        }
    }
    
//    First check for city id exist. Then get hotel list from api
    func getHotelList(finishGetHotelList: @escaping ()->Void){
        
        self.getCityIdFromCache { id in
            DataSource.sharedInstance.getHotelIdList(id: id, page: self.hotelPage) { response in
                switch response {
                case.success(let successHotelIdResponse):
                    guard !successHotelIdResponse.data.body.searchResults.results.isEmpty else {return}
                    if self.hotelEntity == nil {
                        self.hotelEntity = successHotelIdResponse
                    } else {
                        self.hotelEntity?.data.body.searchResults.results += successHotelIdResponse.data.body.searchResults.results
                    }
                    self.hotelPage += 1
                    finishGetHotelList()
                case.failure(let unsuccessfulHotelIdResponse):
                    print("error \(unsuccessfulHotelIdResponse.localizedDescription)")
                }
            }
        }
        
    }
    
//    For get flight response form api
    func getFlightList(finishGetFlightList : @escaping ()->Void){
        DataSource.sharedInstance.getFlights { flightResponse in
            switch flightResponse {
            case.success(let successFlightList):
                self.flightEntity = successFlightList
                finishGetFlightList()
            case.failure(let unsuccessfulFlightList):
                print("error")
                
            }
        }
    }
}
