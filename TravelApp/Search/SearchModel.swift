//
//  SearchModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 7.10.2022.
//

import Foundation

class SearchModel {
    
    private var lastPage: Int = 1
    private var lastQuery : String?
    private var cityIdResponse: CityIdResponse?
    private var flightItemResponseList: [FlightItemResponse] = []
    var filteredFlightList: [FlightItemResponse] = []
    var hotelEntity: HotelResponse?
    
//    For search flights
    func searchFlightList(finishGetFlightList : @escaping ()->Void){
        DataSource.sharedInstance.getFlights { flightResponse in
            switch flightResponse {
            case.success(let successFlightList):
                self.flightItemResponseList = successFlightList
                finishGetFlightList()
            case.failure(let unsuccessfulFlightList):
                print("error\(unsuccessfulFlightList.localizedDescription)")
                
            }
        }
    }
    
//    If city id and query is same with last search, we dont want to send request again.
//    If city id doesn't change user do pagination.
    private func getCityIdFromCache(query:String, finishGetId: @escaping (String)->Void) {
        if let cityIdResponse = cityIdResponse, query == lastQuery {
            finishGetId(cityIdResponse.suggestions.first?.entities.first?.destinationId ?? "1341107")
        } else {
            self.lastPage = 1
            self.lastQuery = nil
            self.hotelEntity = nil
            DataSource.sharedInstance.getHotelSearch(query: query) { cityIdResponse in
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
    
//    Search for hotels
    func searchHotelList(query: String? = nil, finishGetHotelList : @escaping ()->Void, shouldShowEmptyView : @escaping (Bool) -> Void){
        
        shouldShowEmptyView(false)
        
        getCityIdFromCache(query: query ?? (lastQuery ?? "")) { id in
            DataSource.sharedInstance.getHotelIdList(id: id, page: self.lastPage) { result in
                switch result {
                case .success(let response):
                    if self.lastPage == 1 && response.data.body.searchResults.results.isEmpty {
                        shouldShowEmptyView(true)
                    }
                    guard !response.data.body.searchResults.results.isEmpty else {return}
                    if self.hotelEntity == nil {
                        self.hotelEntity = response
                    } else {
                        self.hotelEntity?.data.body.searchResults.results += response.data.body.searchResults.results
                    }
                    
                    self.lastPage += 1
                    self.lastQuery = query
                    finishGetHotelList()
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
//    We filtered flightItemResponses for flight number
    func filterForFlightNumber(flightNumber: Int) {
        self.filteredFlightList = self.flightItemResponseList.filter { flight in
            return flight.flightNumber?.description.contains(flightNumber.description) ?? false
        }
    }
    
    
}
