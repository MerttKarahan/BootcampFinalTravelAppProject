//
//  TabBarBuilder.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import UIKit

class TabBarViewController: UITabBarController, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBar()
        
    }
    
//    For set tab bar elements and set image 
    func createTabBar() {
        
        let firstItem = HomeViewBuilder.build()
        let secondItem = SearchViewBuilder.build()
        let thirdItem = BookMarkBuilder.build()
        
        
        firstItem.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"homeTabBar"), selectedImage: UIImage(named: "homeTabBarClicked"))
        secondItem.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"searchTabBar"), selectedImage: UIImage(named: "searchTabBarClicked"))
        thirdItem.tabBarItem = UITabBarItem(title: nil, image: UIImage(named:"bookmarksTabBar"), selectedImage: UIImage(named: "bookmarkTabBarClicked"))
        
        self.setViewControllers([firstItem, secondItem, thirdItem], animated: true)
    }
    
}
