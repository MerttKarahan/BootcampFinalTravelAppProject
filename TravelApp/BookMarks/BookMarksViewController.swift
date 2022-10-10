//
//  BookMarksViewController.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import UIKit

class BookMarksViewController: UIViewController {
    
    @IBOutlet weak var bookMarksCollectionView: UICollectionView!
    
    var bookMarksViewModel: BookMarksViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        collectionViewCellRegister()
        
    }
    
//    Every viewWillAppear, get data from CoreData
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookMarksViewModel?.getHotelDataFromCoreData()
        bookMarksViewModel?.getFlightDataFromCoreData()
        bookMarksCollectionView.reloadData()
    }
    
}

extension BookMarksViewController {
    func collectionViewSetup() {
        bookMarksCollectionView.delegate = self
        bookMarksCollectionView.dataSource = self
    }
    
    func collectionViewCellRegister() {
        self.bookMarksCollectionView.register(.init(nibName: "BookMarksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BookMarksCollectionViewCell")
    }
}

extension BookMarksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? bookMarksViewModel?.numberOfFlightItems ?? 0 : bookMarksViewModel?.numberOfHotelItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookMarksCollectionView.dequeueReusableCell(withReuseIdentifier: "BookMarksCollectionViewCell", for: indexPath) as! BookMarksCollectionViewCell
        if indexPath.section == 0 {
            let response = bookMarksViewModel?.flightCoreDataList[indexPath.row]
            cell.configure(response: response)
        } else {
            let response = bookMarksViewModel?.hotelResultCoreDataList[indexPath.row]
            cell.configure(response: response)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (UIScreen.main.bounds.width - 30)
        return CGSize(width: cellWidth, height: cellWidth * 0.42)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if let model = bookMarksViewModel?.flightItemAtIndex(index: indexPath.row) {
                let vc = FlightDetailBuilder.flightBuilder(flightResponse: model)
                navigationController?.pushViewController(vc, animated: true)
            }

        } else {
            if let model = bookMarksViewModel?.hotelItemAtIndex(index: indexPath.row){
                let vc = HotelDetailBuilder.hotelBuilder(hotelResponse: model)
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
}
