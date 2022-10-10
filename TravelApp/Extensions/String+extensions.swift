//
//  String+extensions.swift
//  TravelApp
//
//  Created by Mert Karahan on 10.10.2022.
//

import Foundation

extension String {
     // Convert response date to readable date
    var convertToReadable: String {
        // We can use DateFormatter for string to date or date to string conversion
        let responseDateFormatter = DateFormatter()
        responseDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        guard let date = responseDateFormatter.date(from: self) else { return "" }
        return displayDateFormatter.string(from: date)
    }
    
}
