//
//  HomeViewModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation

class HomeViewModel {
    
    weak var homeViewModelDelegate: HomeViewModelDelegate?
    var homeModel: HomeModel?
    
//    For determine number of collectionView items
    var numberOfItems: Int {
        return homeModel?.jsonData.count ?? 0
    }
    
//    For determine collectionView elements in index
    func newsItem(at index:Int) -> HomeEntity? {
        return homeModel?.jsonData[index]
    }
    
    func getDataFromModel() {
        homeModel?.fetchJsonObjects(finishFetching: {
            self.homeViewModelDelegate?.reloadData()
        })
    }
}
