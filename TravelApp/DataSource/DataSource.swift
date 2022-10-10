//
//  ListModel.swift
//  TravelApp
//
//  Created by Mert Karahan on 29.09.2022.
//

//"X-RapidAPI-Key":"61fdc98b96msha53f9ba2fa73739p16017fjsna9e7f618e7e4"

//65842f2be768d1fa8d1c58cfe3366eba

import Foundation
import Alamofire

//Flight api constants
struct FlightConstans{
    static var baseUrl = "https://travelpayouts-travelpayouts-flight-data-v1.p.rapidapi.com/v1"
    static var headers : HTTPHeaders = ["X-Access-Token":"8a1b67a05ac0c14b02c4887e1a1c3723", "X-RapidAPI-Key":"e7509bc4aamsh17d99118abb19ebp1c5d36jsnc61eb3951e7c", "X-RapidAPI-Host":"travelpayouts-travelpayouts-flight-data-v1.p.rapidapi.com"]
}

// Hotel api constants
struct HotelsConstants {
    static var baseUrl = "https://hotels4.p.rapidapi.com"
    static var headers : HTTPHeaders = ["X-RapidAPI-Key":"e7509bc4aamsh17d99118abb19ebp1c5d36jsnc61eb3951e7c", "X-RapidAPI-Host":"hotels4.p.rapidapi.com"]
}

enum FlightPath: String{
    case eachDayOfMounth = "/prices/calendar"
    
    var flightFullPath : String {
        return FlightConstans.baseUrl + self.rawValue
    }
}

enum HotelsPath: String{
    case cityIdList = "/locations/v2/search"
    case hotelIdList = "/properties/list"
    case hotelDetails = "/properties/get-details"
    
    var hotelsFullPath: String{
        return HotelsConstants.baseUrl + self.rawValue
    }
}

class DataSource{
    
    static let sharedInstance = DataSource()
    
// For get flight response
    func getFlights(finishGetFlights: @escaping ((Result<[FlightItemResponse], AFError>) -> Void)) {
        
        var parameters : [String:Any] = [:]
        parameters["calendar_type"] = "departure_date"
        parameters["destination"] = "IST"
        parameters["origin"] = "ANK"
        parameters["depart_date"] = "2022-11-5"
        parameters["currency"] = "TRY"
        parameters["return_date"] = "2022-11-14"
        
        let request = AF.request(FlightPath.eachDayOfMounth.flightFullPath,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: FlightConstans.headers)
        
        request.response { data in
            do {
                //For JSONSerialization, data must be swift data type. Otherwise we cannot do JSONSerialization. So we convert AF data to swift data below.
                guard let swiftData = data.data else {return}
                
                guard let jsonResponse = try JSONSerialization.jsonObject(with: swiftData) as? [String:Any] else {return}
                
                if let flightList = jsonResponse["data"] as? [String:Any] {
                    
                    let responseList : [FlightItemResponse] = try flightList.compactMap { flightDict in
                        guard let dict = flightDict.value as? [String:Any] else {return nil}
                        let flightData = try JSONSerialization.data(withJSONObject: dict, options: [])
                        let model = try JSONDecoder().decode(FlightItemResponse.self, from: flightData)
                        return model
                    }
                    
                    finishGetFlights(.success(responseList))

                }
            } catch {
                print("ERROR")
            }
        }
    }
    
//    For get city id from api
    func getHotelSearch(query:String = "IST", finishGetHotelSearch: @escaping ((Result<CityIdResponse, AFError>) -> Void)) {
        
        var parameters : [String:Any] = [:]
        parameters["query"] = query
        
        let request = AF.request(HotelsPath.cityIdList.hotelsFullPath,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: HotelsConstants.headers)
        
        request.responseDecodable(of: CityIdResponse.self) { response in
            if let value = response.value {
                finishGetHotelSearch(.success(value))
            } else if let error = response.error {
                finishGetHotelSearch(.failure(error))
            }
        }
    }
    
//    For get hotel id list from api with using city id above
    func getHotelIdList(id: String, page:Int, finishGetHotelIdList: @escaping ((Result<HotelResponse, AFError>) -> Void)) {
        
        var parameters : [String:Any] = [:]
        parameters["destinationId"] = id
        parameters["pageNumber"] = "\(page)"
        parameters["pageSize"] = "25"
        parameters["checkIn"] = "2022-11-10"
        parameters["checkOut"] = "2022-11-14"
        parameters["adults1"] = "1"
        parameters["sortOrder"] = "PRICE"
        parameters["locale"] = "tr-TR"
        parameters["currency"] = "TRY"
        
        let request = AF.request(HotelsPath.hotelIdList.hotelsFullPath,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: HotelsConstants.headers)
        
        request.responseDecodable(of: HotelResponse.self) {response in
            if let value = response.value {
                finishGetHotelIdList(.success(value))
                print("merttest: page: \(page), first title: \(response.value?.data.body.searchResults.results.first?.name)")
            } else if let error = response.error {
                finishGetHotelIdList(.failure(error))
            }
        }
    }
    
//    For get hotel detail from api with using hotel id above
    func getHotelDetails(hotelId: Int, finishGetHotelDetails: @escaping ((Result<HotelDetailResponse, AFError>)->Void)) {
        
        var parameters: [String: Any] = [:]
        parameters["id"] = hotelId
        parameters["checkIn"] = "2022-11-10"
        parameters["checkOut"] = "2022-11-14"
        parameters["adults"] = "1"
        parameters["currency"] = "TRY"
        parameters["locale"] = "tr-TR"
        
        let request = AF.request(HotelsPath.hotelDetails.hotelsFullPath,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: HotelsConstants.headers)
        
        request.responseDecodable(of: HotelDetailResponse.self) {response in
            
            if let value = response.value {
                finishGetHotelDetails(.success(value))
            } else if let error = response.error {
                finishGetHotelDetails(.failure(error))
            }
        }
    }
    
}
