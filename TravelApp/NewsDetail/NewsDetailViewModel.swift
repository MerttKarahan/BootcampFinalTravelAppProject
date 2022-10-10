//
//  NewsDetailViewModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 10.10.2022.
//

import Foundation

protocol NewsDetailViewProtocol {
    var image:String {get}
    var publishedAt:String {get}
    var title:String {get}
    var description:String {get}
    var content:String {get}
}

class NewsDetailViewModel: NewsDetailViewProtocol {
    
    var entity: HomeEntity?
    
    init(entity:HomeEntity){
        self.entity = entity
    }
    
    var image:String {
        return entity?.image ?? ""
    }
    
    var publishedAt:String {
        return entity?.publishedAt ?? ""
    }
    
    var title:String {
        return entity?.title ?? ""
    }
    
    var description:String {
        return entity?.description ?? ""
    }
    
    var content:String {
        return entity?.content ?? ""
    }
}
