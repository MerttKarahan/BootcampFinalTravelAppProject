//
//  ListViewModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation

protocol ListViewModelProtocol {
    func getDataFromModel()
    func itemAtIndex(index: Int) -> Decodable?
    func willDisplayCell(index: Int)
    var numberOfItems: Int {get}
    var listType: ListType {get}
    var listViewModelDelegate: ListViewModelDelegate? {get set}
    
}

protocol ListViewModelDelegate: AnyObject {
    func reloadData()
}

class ListViewModel: ListViewModelProtocol{
    
    weak var listViewModelDelegate: ListViewModelDelegate?
    
    
    var listModel : ListModelProtocol =  ListModel()
    var listType: ListType
    
    init(listType : ListType) {
        self.listType = listType
    }

//    For determine number of items in hotel or flight response
    var numberOfItems: Int{
        switch listType {
        case .Flight:
            return listModel.flightEntity?.count ?? 0
        case .Hotels:
            return listModel.hotelEntity?.data.body.searchResults.results.count  ?? 0
        }
    }
    
//    For determine item in index
    func itemAtIndex(index: Int) -> Decodable? {
        switch listType {
        case .Flight:
            return listModel.flightEntity?[index]
        case .Hotels:
            return listModel.hotelEntity?.data.body.searchResults.results[index]
        }
    }
    
//    Get data for selected enum type. And then reload data
    func getDataFromModel() {
        switch listType {
        case .Flight:
            listModel.getFlightList {
                self.listViewModelDelegate?.reloadData()
            }
        case .Hotels:
            listModel.getHotelList {
                self.listViewModelDelegate?.reloadData()
            }
        }
    }
    
//    For pagination
    func willDisplayCell(index: Int) {
        if index == self.numberOfItems - 1 {
            getDataFromModel()
        }
    }
    
}

