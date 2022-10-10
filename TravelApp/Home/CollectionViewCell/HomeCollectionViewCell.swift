//
//  HomeCollectionViewCell.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionViewUI()
        setCollectionViewShadow()
    }
    
    func setCellView(entity: HomeEntity) {
        cellTitle.text = entity.title
        cellImage.setImage(imageUrl: entity.image ?? "")        
    }
    
    //    For set all collectionview UI feature
    func setCollectionViewUI() {
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = 8
    }
    
    func setCollectionViewShadow() {
        self.layer.shadowColor = UIColor(red: 24/255, green: 50/255, blue: 115/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 8)
        self.layer.shadowRadius = 16
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
    
}
