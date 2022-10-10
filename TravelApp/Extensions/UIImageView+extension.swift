//
//  UIImageView+extension.swift
//  TravelApp
//
//  Created by Mert Karahan on 4.10.2022.
//

import Foundation
import Kingfisher


extension UIImageView{
//    This function set image for url which is get from api
    func setImage(imageUrl: String) {
        let url = URL(string: imageUrl)
        self.kf.setImage(with: url)
    }
}
