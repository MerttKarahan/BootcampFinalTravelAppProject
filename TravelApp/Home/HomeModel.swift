//
//  HomeModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import Foundation

class HomeModel {
    
    var jsonData: [HomeEntity] = []
    
//    Fetch local json endpoints
    func fetchJsonObjects(finishFetching: @escaping ()->Void) {
        guard let fileLocation = Bundle.main.url(forResource: "news", withExtension: "json") else {return}
        
        do {
            let data = try? Data(contentsOf: fileLocation)
            self.jsonData = try! JSONDecoder().decode([HomeEntity].self, from: data!)
            finishFetching()
        } catch {
            print("Fetching Error!")
        }
    }
}
