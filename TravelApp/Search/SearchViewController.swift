//
//  SearchViewController.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

import UIKit

class SearchViewController: UIViewController{
    
    struct Constant {
        static let activeColor = UIColor(red: 1, green: 0.28, blue: 0.375, alpha: 1)
        static let deactiveColor = UIColor(red: 0.76, green: 0.771, blue: 0.84, alpha: 1)
        static let borderColor = UIColor(red: 224/255, green: 226/255, blue: 235/255, alpha: 1)
    }
    
    @IBOutlet weak var flightLineView: UIView!
    @IBOutlet weak var hotelLineView: UIView!
    @IBOutlet weak var emptyView: UIStackView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var hotelButton: UIButton!
    @IBOutlet weak var flightsButton: UIButton!
    @IBOutlet weak var flightImage: UIImageView!
    @IBOutlet weak var searchBorderView: UIView!
    
    var timer: Timer?
    
    var searchViewModel: SearchViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        buttonConfigure()
        configureUI()
        searchViewModel?.fetchFlights()
    }
    
    @IBAction func hotelButtonClicked(_ sender: Any) {
        searchViewModel?.selectedSearchType = .hotel
        buttonConfigure()
    }
    
    @IBAction func flightsButtonClicked(_ sender: Any) {
        searchViewModel?.selectedSearchType = .flights
        buttonConfigure()
    }
}

private extension SearchViewController {
    
    //    For set search tab elements UI features
    func buttonConfigure() {
        switch searchViewModel?.selectedSearchType {
        case .hotel:
            self.hotelLineView.isHidden = false
            self.flightLineView.isHidden = true
            self.hotelButton.tintColor = Constant.activeColor
            self.hotelImage.tintColor = Constant.activeColor
            self.flightsButton.tintColor = Constant.deactiveColor
            self.flightImage.tintColor = Constant.deactiveColor
        case .flights:
            self.hotelLineView.isHidden = true
            self.flightLineView.isHidden = false
            self.flightsButton.tintColor = Constant.activeColor
            self.flightImage.tintColor = Constant.activeColor
            self.hotelButton.tintColor = Constant.deactiveColor
            self.hotelImage.tintColor = Constant.deactiveColor
        default:
            break
        }
    }
    
    //    We are not use searchBar. We create textField for search operations. Thats why we should set custom search bar features from figma.
    func configureUI() {
        self.searchBorderView.layer.masksToBounds = true
        self.searchBorderView.layer.borderColor = Constant.borderColor.cgColor
        self.searchBorderView.layer.borderWidth = 2
        self.searchBorderView.layer.cornerRadius = 4
        self.searchTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func tableViewSetup() {
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.register(.init(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
}

extension SearchViewController {
    
    //    For search after three elements writed and after 0.5 second later
    @objc private func textDidChange() {
        
        let text = searchTextField.text ?? ""
        
        guard text.count >= 3 else { return }
        scheduleTimer()
        
    }
    
    func scheduleTimer() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            let text = self.searchTextField.text ?? ""
            self.searchViewModel?.search(text: text)
        })
    }
}

extension SearchViewController: SearchViewModelDelegate {
    
    func shouldShowEmptyView(_ show: Bool) {
        DispatchQueue.main.async {
            self.emptyView.isHidden = !show
        }
    }
    
    
    // When text change, new search element listed from top of screen
    func scrollListToTop() {
        DispatchQueue.main.async {
            self.searchTableView.setContentOffset(.zero, animated: true)
        }
    }
    
    //    For reload search data. We don't have to use DispatchQueue because the text is not accessible before the data is received, but we use it so that both search and hotel have the same operation.
    func reloadData() {
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
    //    For hidden textfiled until fetch response.
    func didFetchFlightList() {
        DispatchQueue.main.async {
            self.searchTextField.isHidden = false
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell()}
        
        if let model = searchViewModel?.itemAtIndex(indexPath.row){
            cell.configure(response: model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let response = searchViewModel?.itemAtIndex(indexPath.row) as? FlightItemResponse {
            let VC = FlightDetailBuilder.flightBuilder(flightResponse: response)
            self.navigationController?.pushViewController(VC, animated: true)
        } else if let response = searchViewModel?.itemAtIndex(indexPath.row) as? HotelResult{
            let VC = HotelDetailBuilder.hotelBuilder(hotelResponse: response)
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        searchViewModel?.willDisplay(index: indexPath.row)
    }
}
