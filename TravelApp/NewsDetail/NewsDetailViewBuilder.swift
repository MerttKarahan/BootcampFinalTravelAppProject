//
//  NewsDetailViewBuilder.swift
//  TravelApp
//
//  Created by Mert Karahan on 10.10.2022.
//

import Foundation
import UIKit

struct NewsDetailViewBuilder {
    static func build(entityFromHome: HomeEntity) -> UIViewController {
        let vc = NewsDetailViewController()
        let vm = NewsDetailViewModel(entity: entityFromHome)
        vc.newsDetailViewModel = vm
        return vc
    }
}
