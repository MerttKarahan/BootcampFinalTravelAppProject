//
//  HomeViewBuilder.swift
//  TravelApp
//
//  Created by Mert Karahan on 7.10.2022.
//

import Foundation
import UIKit

struct HomeViewBuilder {
    
    private init(){
        
    }
    
    static func build() -> UIViewController {
        let vc = HomeViewController()
        let vm = HomeViewModel()
        let model = HomeModel()
        
        vm.homeModel = model
        vc.homeViewModel = vm
        
        return vc
    }
}
