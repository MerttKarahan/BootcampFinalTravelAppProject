//
//  File.swift
//  TravelApp
//
//  Created by Mert Karahan on 7.10.2022.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static var coreDataStack : CoreDataStack{
        return AppDelegate.sharedAppDelegate.coreDataStack
    }
    
//    For save flight object to CoreData
    static func saveFlight(flight: FlightItemResponse) {
        
        let data = Flight(context: coreDataStack.managedContext)
        
        if let departureAt = flight.departureAt {
            data.setValue(departureAt, forKey: #keyPath(Flight.departureAt))
        }
        
        if let destination = flight.destination {
            data.setValue(destination, forKey: #keyPath(Flight.destination))
        }

        data.setValue(Date(), forKey: #keyPath(Flight.date))
        
        if let number = flight.flightNumber {
            data.setValue(number, forKey: #keyPath(Flight.number))
        }
        
        if let origin = flight.origin {
            data.setValue(origin, forKey: #keyPath(Flight.origin))
        }
        
        if let price = flight.price{
            data.setValue(price, forKey: #keyPath(Flight.price))
        }
        
        if let returnAt = flight.returnAt {
            data.setValue(returnAt, forKey: #keyPath(Flight.returnAt))
        }
        
        coreDataStack.save()
        
    }
    
//    For save hotel object to CoreData
    static func saveHotel(hotel: HotelResult) {
        
        let data = Hotel(context: coreDataStack.managedContext)
        
        data.setValue(hotel.name, forKey: #keyPath(Hotel.name))
        data.setValue(hotel.starRating, forKey: #keyPath(Hotel.starRating))
        data.setValue(hotel.id, forKey: #keyPath(Hotel.hotelId))
        data.setValue(Date(), forKey: #keyPath(Hotel.date))
        
        coreDataStack.save()
        
    }
    
//    For get flight object from CoreData
    static func getFlights() -> [FlightItemResponse] {
        
        
        let fetchFlightRequest: NSFetchRequest<Flight> = Flight.fetchRequest()
        
        let sortByDate = NSSortDescriptor(key: #keyPath(Flight.date), ascending: false)
        
        fetchFlightRequest.sortDescriptors = [sortByDate]
        do {
            let context = self.coreDataStack.managedContext
            let results = try context.fetch(fetchFlightRequest)
            
            return results.map({ result in
                return FlightItemResponse(origin: result.origin,
                                          destination: result.destination,
                                          price: Int(result.price),
                                          flightNumber: Int(result.number),
                                          departureAt: result.departureAt,
                                          returnAt: result.returnAt)
            })
        }catch {
            return []
        }
    }
    
//    For get hotel object from CoreData
    static func getHotels() -> [HotelResult] {
        let fetchHotelResultRequest: NSFetchRequest<Hotel> = Hotel.fetchRequest()
        
        let sortByDate = NSSortDescriptor(key: #keyPath(Hotel.date), ascending: false)
        
        fetchHotelResultRequest.sortDescriptors = [sortByDate]
        do {
            let context = coreDataStack.managedContext
            let results = try context.fetch(fetchHotelResultRequest)
            
            return results.map({ result in
                return HotelResult(id: Int(Int64(result.hotelId)),
                                   name: result.name ?? "",
                                   starRating: Float(result.starRating))
            })
        } catch {
            return []
        }
    }
    
//    Check flight object flight number, departureAt and returnAt.
    static func coreDataFlightCheck(flightResponse: FlightItemResponse) -> Bool {
        
        let fetchFlightRequest: NSFetchRequest<Flight> = Flight.fetchRequest()
        
        let predicate = NSPredicate(format: "number == %@ AND departureAt == %@ AND returnAt == %@" , NSNumber(integerLiteral: flightResponse.flightNumber ?? 0), flightResponse.departureAt ?? "", flightResponse.returnAt ?? "")
        fetchFlightRequest.predicate = predicate
        
        return !isEmpty(fetchRequest: fetchFlightRequest)
        
        
    }
    
    //    Check hotel object hotelId for determine CoreData operations (add or delete)
    static func coreDataHotelCheck(hotelId: Int) -> Bool {
        
        let fetchHotelRequest: NSFetchRequest<Hotel> = Hotel.fetchRequest()
        
        let predicate = NSPredicate(format: "hotelId == %@", NSNumber(integerLiteral: hotelId))
        fetchHotelRequest.predicate = predicate
        
        return !isEmpty(fetchRequest: fetchHotelRequest)
        
        
    }
    
//    For
    private static func isEmpty<T:NSManagedObject>(fetchRequest: NSFetchRequest<T>) -> Bool{
        
        do {
            let context = self.coreDataStack.managedContext
            let results = try context.fetch(fetchRequest)
            
            return results.isEmpty
            
        }catch {
            return false
        }
    }
    
    static func deleteFlight(flightResponse: FlightItemResponse) {
        
        let fetchFlightRequest: NSFetchRequest<Flight> = Flight.fetchRequest()
        
        let predicate = NSPredicate(format: "number == %@ AND departureAt == %@ AND returnAt == %@" , NSNumber(integerLiteral: flightResponse.flightNumber ?? 0), flightResponse.departureAt ?? "", flightResponse.returnAt ?? "")
        fetchFlightRequest.predicate = predicate
        
        delete(fetchRequest: fetchFlightRequest)
    }
    
    static func deleteHotel(hotelId: Int) {
        
        let fetchHotelRequest: NSFetchRequest<Hotel> = Hotel.fetchRequest()
        
        let predicate = NSPredicate(format: "hotelId == %@", NSNumber(integerLiteral: hotelId))
        fetchHotelRequest.predicate = predicate
        
        delete(fetchRequest: fetchHotelRequest)
    }
    
    private static func delete<T:NSManagedObject>(fetchRequest: NSFetchRequest<T>) {
        do {
            let context = coreDataStack.managedContext
            let result = try context.fetch(fetchRequest)
            
            for result in result {
                context.delete(result)
            }
            
            self.coreDataStack.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
