//
//  ListViewController.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var listViewModel : ListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listViewModel?.getDataFromModel()
        collectionViewSetup()
        collectionViewCellRegister()
        setLabelTitle()
        backButtonUI()
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

// Reload hotel or flight data. And return main thread
extension ListViewController: ListViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.listCollectionView.reloadData()
        }
    }
}

extension ListViewController {
    func collectionViewSetup(){
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
    
    func collectionViewCellRegister() {
        self.listCollectionView.register(.init(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCollectionViewCell")
    }
    
//    ListViewController has label on top of screen. This label change for flights or hotels
    func setLabelTitle() {
        if listViewModel?.listType == .Flight {
            self.listLabel.text = "Flights"
        } else if listViewModel?.listType == .Hotels {
            self.listLabel.text = "Hotels"
        }
    }
    
//    Figma has custom back button. So back buttom created and set uı features
    func backButtonUI() {
        self.backButton.setTitle("", for: .normal)
        let backButtonImage = UIImage(named: "backButton")
        self.backButton.setImage(backButtonImage?.withRenderingMode(.alwaysOriginal), for: .normal)
    }

    
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listViewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
        
        if let response = listViewModel?.itemAtIndex(index: indexPath.row){
            cell.configure(response: response)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (UIScreen.main.bounds.width - 30)
        return CGSize(width: cellWidth, height: cellWidth * 0.42) // 0.42 coming from figma cell ratio
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        Flight and hotel builder accept decodable object and if created response can cast as decodable object, navigation can push other view controller
        if let response = listViewModel?.itemAtIndex(index: indexPath.row) as? FlightItemResponse {
            let VC = FlightDetailBuilder.flightBuilder(flightResponse: response)
            self.navigationController?.pushViewController(VC, animated: true)
        } else if let response = listViewModel?.itemAtIndex(index: indexPath.row) as? HotelResult{
            let VC = HotelDetailBuilder.hotelBuilder(hotelResponse: response)
            self.navigationController?.pushViewController(VC, animated: true)
        } else {
            print("MERTTEST")
        }
    }
    
//    This func is called when every cell is visible.
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        listViewModel?.willDisplayCell(index: indexPath.row)
    }
}

