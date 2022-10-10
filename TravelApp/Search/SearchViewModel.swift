//
//  SearchViewModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didFetchFlightList()
    func reloadData()
    func scrollListToTop()
    func shouldShowEmptyView(_ show: Bool)
}

protocol SearchViewModelProtocol {
    var selectedSearchType: SearchType {get set}
    var searchViewModelDelegate: SearchViewModelDelegate? {get set}
    var numberOfItems:Int {get}
    func fetchFlights()
    func itemAtIndex(_ index: Int) -> Decodable?
    func search(text:String)
    func willDisplay(index:Int)
}

class SearchViewModel: SearchViewModelProtocol {
    
    weak var searchViewModelDelegate: SearchViewModelDelegate?
    var searchModel: SearchModel?
    
//    This enum exists to use the same functions for hotel and flight
    var selectedSearchType: SearchType = .hotel
    
//    For determine number of tableView items
    var numberOfItems:Int {
        switch selectedSearchType {
        case .hotel:
            return searchModel?.hotelEntity?.data.body.searchResults.results.count ?? 0
        case .flights:
            return searchModel?.filteredFlightList.count ?? 0
        }
    }
    
//    For determine tableView element for index
    func itemAtIndex(_ index: Int) -> Decodable? {
        switch selectedSearchType {
        case .hotel:
            return searchModel?.hotelEntity?.data.body.searchResults.results[index]
        case .flights:
            return searchModel?.filteredFlightList[index]
        }
    }
    
    func fetchFlights() {
        searchModel?.searchFlightList(finishGetFlightList: { [weak self] in
            self?.searchViewModelDelegate?.didFetchFlightList()
        })
    }
    
//    Search function for hotel and flight item
    func search(text:String) {
        switch selectedSearchType {
        case .hotel:
            searchModel?.searchHotelList(query: text, finishGetHotelList: {
                self.searchViewModelDelegate?.scrollListToTop()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.searchViewModelDelegate?.reloadData()
                })
            }, shouldShowEmptyView: { shouldShow in
                self.searchViewModelDelegate?.shouldShowEmptyView(shouldShow)
            })
        case .flights:
            guard let intText = Int(text) else {return}
            searchModel?.filterForFlightNumber(flightNumber: intText)
            searchViewModelDelegate?.reloadData()
        }
    }
    
//    When hotels searched, we use pagination
    func willDisplay(index:Int) {
        switch selectedSearchType {
        case .hotel:
            if index == self.numberOfItems - 1 {
                searchModel?.searchHotelList(finishGetHotelList: {
                    self.searchViewModelDelegate?.reloadData()
                }, shouldShowEmptyView: { shouldShow in
                    self.searchViewModelDelegate?.shouldShowEmptyView(shouldShow)
                })
            }
        case .flights:
            break
        }
    }
}
