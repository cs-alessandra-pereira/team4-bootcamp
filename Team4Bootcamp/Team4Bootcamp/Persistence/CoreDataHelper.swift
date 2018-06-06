//
//  CoreDataHelper.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 27/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import CoreData
class CoreDataHelper {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: PersistenceConstants.persistenceContainerName)
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            print(storeDescription)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let err = error as NSError
                fatalError("Unresolved errror \(err), \(err.userInfo)")
            }
        }
    }
}

public enum CoreDataErrorHelper: Error {
    case duplicateEntry, noResults, badPredicate, unknown
}
