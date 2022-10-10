//
//  Hotel+CoreDataProperties.swift
//  
//
//  Created by Mert Karahan on 4.10.2022.
//
//

import Foundation
import CoreData

@objc(Hotel)
public class Hotel: NSManagedObject {

}


extension Hotel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hotel> {
        return NSFetchRequest<Hotel>(entityName: "Hotel")
    }

    @NSManaged public var hotelId: Int64
    @NSManaged public var name: String?
    @NSManaged public var starRating: Float
    @NSManaged public var date: Date


}
