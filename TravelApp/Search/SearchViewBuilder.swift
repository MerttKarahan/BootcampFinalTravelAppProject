//
//  SearchViewBuilder.swift
//  TravelApp
//
//  Created by Mert Karahan on 7.10.2022.
//

import Foundation
import UIKit

struct SearchViewBuilder {
    
    private init() {
        
    }
    
    static func build() -> UIViewController {
        let vc = SearchViewController()
        let vm = SearchViewModel()
        let model = SearchModel()
        
        vm.searchModel = model
        vc.searchViewModel = vm
        vm.searchViewModelDelegate = vc
        
        return vc
    }
}
