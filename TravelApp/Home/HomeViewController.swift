//
//  HomeViewController.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
}

class HomeViewController: UIViewController{
    
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var flightButton: UIButton!
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var hotelButton: UIButton!
    @IBOutlet weak var hotelsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var homeViewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel?.getDataFromModel()
        registerCollectionViewCell()
        setDelegateDataSource()
        setHomeViewControllerUI()
        setButtonShadow(for: self.hotelsView)
        setButtonShadow(for: self.flightView)
        homeViewModel?.homeViewModelDelegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func flightButtonClicked(_ sender: Any) {
        let listVC = ListBuilder.build(listType: .Flight)
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    @IBAction func hotelButtonClick(_ sender: Any) {
        let listVC = ListBuilder.build(listType: .Hotels)
        self.navigationController?.pushViewController(listVC, animated: true)
    }
}

//For reload news data
extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        if let news = homeViewModel?.newsItem(at: indexPath.row) {
            cell.setCellView(entity: news)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (UIScreen.main.bounds.width ) / 1.6
        return CGSize(width: cellWidth, height: self.collectionView.bounds.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let entity = homeViewModel?.newsItem(at: indexPath.row){
            let vc = NewsDetailViewBuilder.build(entityFromHome: entity)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

private extension HomeViewController {
    
    //    For set all elements in HomeViewController
    func setHomeViewControllerUI() {
        self.homeImage.image = UIImage(named: "homeImage")
        self.homeImage.layer.shadowColor = UIColor.black.cgColor
        self.homeImage.layer.shadowOpacity = 0.6
        self.homeImage.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        self.homeImage.layer.shadowRadius = 6.0
        self.homeImage.layer.masksToBounds = false
        
        self.flightButton.setTitle("", for: .normal)
        self.flightButton.setImage(.init(named: "flight"), for: .normal)
        
        self.hotelButton.setTitle("", for: .normal)
        self.hotelButton.setImage(.init(named: "hotel"), for: .normal)
        
        self.hotelsView.layer.cornerRadius = 8.0
        self.hotelsView.layer.masksToBounds = false
        
        self.flightView.layer.cornerRadius = 8.0
        self.flightView.layer.masksToBounds = false
        
        self.collectionView.layer.masksToBounds = false
    }
    
    func registerCollectionViewCell() {
        collectionView.register(.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    func setDelegateDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setButtonShadow(for targetView: UIView) {
        let shadows = UIView()
        shadows.frame = targetView.frame
        shadows.clipsToBounds = false
        targetView.insertSubview(shadows, at: 0)
        
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 8)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 25
        layer0.shadowOffset = CGSize(width: 0, height: 0)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
    }
}
