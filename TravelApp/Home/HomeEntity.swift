//
//  HomeEntity.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation

struct HomeEntity:Decodable {
    var sortId : Int?
    var title : String?
    var description : String?
    var content : String?
    var image : String?
    var publishedAt : String?
}
