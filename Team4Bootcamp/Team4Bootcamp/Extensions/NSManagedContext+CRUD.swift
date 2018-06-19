//
//  NSManagedContext+CRUD.swift
//  Team4Bootcamp
//
//  Created by Antonio Rodrigues on 21/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    
    func fetchObjects <T: NSManagedObject>(withRequest request: NSFetchRequest<T>) throws -> [T] {
        let fetchedResult = try self.fetch(request)
        return fetchedResult
    }
    
    func previouslyInserted<T: NSManagedObject>(_ entityClass: T.Type, predicateForDuplicityCheck: NSPredicate) throws -> Bool {
        let request = self.buildNSFetchRequest(forClass: entityClass, predicate: predicateForDuplicityCheck)
        let existingResults = try fetchObjects(withRequest: request)
        return existingResults.count == 0 ? false : true
    }
    
    func deleteObjects<T: NSManagedObject>(_ entityClass: T.Type, predicate: NSPredicate? = nil) throws -> Int {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        request.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        let result = try self.execute(deleteRequest) as? NSBatchDeleteResult
        try self.save()
        guard let objectIDs = result?.result as? [NSManagedObjectID] else {
            return 0
        }
        
        return objectIDs.count
    }
    
    func buildNSFetchedResultsController<T: NSManagedObject>(withRequest request: NSFetchRequest<T>) -> NSFetchedResultsController<T> {
        let fetchedResultsController = NSFetchedResultsController<T>(
            fetchRequest: request,
            managedObjectContext: self,
            sectionNameKeyPath: nil,
            cacheName: nil)
        return fetchedResultsController
    }
    
    func buildNSFetchRequest <T: NSManagedObject>(forClass entityClass: T.Type, sortBy: [NSSortDescriptor]? = nil, predicate: NSPredicate? = nil)  -> NSFetchRequest<T> {
        let request: NSFetchRequest<T>
        request = NSFetchRequest(entityName: String(describing: entityClass))
        request.returnsObjectsAsFaults = false
        request.predicate = predicate
        request.sortDescriptors = sortBy
        return request
    }

}
