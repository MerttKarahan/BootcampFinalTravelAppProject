//
//  ListBuilder.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation

struct ListBuilder {
    static func build(listType: ListType) -> ListViewController {
        let listVM = ListViewModel(listType: listType)
        let listVC = ListViewController()
        let listM = ListModel()
        listVC.listViewModel = listVM
        listVM.listModel = listM
        listVM.listViewModelDelegate = listVC
        return listVC
    }
    
}
