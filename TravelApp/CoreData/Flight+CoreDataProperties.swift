//
//  Flight+CoreDataProperties.swift
//  
//
//  Created by Mert Karahan on 4.10.2022.
//
//

import Foundation
import CoreData

@objc(Flight)
public class Flight: NSManagedObject {

}


extension Flight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flight> {
        return NSFetchRequest<Flight>(entityName: "Flight")
    }

    @NSManaged public var departureAt: String?
    @NSManaged public var destination: String?
    @NSManaged public var number: Int16
    @NSManaged public var origin: String?
    @NSManaged public var price: Int16
    @NSManaged public var returnAt: String?
    @NSManaged public var date: Date?

}
