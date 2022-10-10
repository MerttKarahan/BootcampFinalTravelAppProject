//
//  BookMarkBuilder.swift
//  TravelApp
//
//  Created by Mert Karahan on 7.10.2022.
//

import Foundation
import UIKit

struct BookMarkBuilder {
    
    private init() {
        
    }
    
    static func build() ->UIViewController {
        let vc = BookMarksViewController()
        let vm = BookMarksViewModel()
        
        vc.bookMarksViewModel = vm
        
        return vc
    }
}
