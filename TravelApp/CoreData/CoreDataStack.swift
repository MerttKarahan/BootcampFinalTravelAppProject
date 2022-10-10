//
//  CoreDataStack.swift
//  myApp
//
//  Created by Mert Karahan on 23.09.2022.
//

import Foundation
import CoreData

class CoreDataStack {
    
//    Name of CoreData model
    private let coreDataModel : String
    
    init(coreDataModel: String) {
        self.coreDataModel = coreDataModel
    }
    
//    Created container for reach CoreData objects.
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: coreDataModel)
//        With loadPersistentStores, container loaded
        container.loadPersistentStores { _, error in
            if let error = error {
                print("ERROR \(error.localizedDescription)")
            }
        }
        return container
    } ()
    
//    For retrieve data from CoreData, should be created context. Context retrieve data with using container.
//    If we want to do something with data in background thread, we must create as private.
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    
    func save() {
        guard managedContext.hasChanges else { return }
        
        do{
            try managedContext.save()
        } catch let error as NSError {
            print("\(error)")
        }
    }
}

