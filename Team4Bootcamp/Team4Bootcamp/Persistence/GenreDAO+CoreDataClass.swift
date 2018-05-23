//
//  GenreDAO+CoreDataClass.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 17/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import CoreData


class GenreDAO: NSManagedObject {
    
    class func addGenres(genres: [GenreId: GenreName], context: NSManagedObjectContext) {
        for (id, name) in genres {
            do {
                let predicate = NSPredicate(format: "id == \(id)")
                let previouslyInserted = try context.previouslyInserted(GenreDAO.self, predicateForDuplicityCheck: predicate)
                if previouslyInserted == false {
                    let newGenreDAO = GenreDAO(context: context)
                    newGenreDAO.id = Int32(id)
                    newGenreDAO.name = name
                    //newGenreDAO.movies = try? MovieDAO.findOrCreateTwitterUser(matching: genre.id, in: context)
                }
            } catch {
                fatalError("Error while checking for Genre id \(id)")
            }
        }
        try? context.save()
    }
    
    class func deleteGenre(context: NSManagedObjectContext, predicate: NSPredicate?) -> Result<Bool, CoreDataErrorHelper> {
        
        do {
            let predicate = predicate
            let result = try context.deleteObjects(GenreDAO.self, predicate: predicate)
            return result > 0 ? Result.success(true) : Result.error(CoreDataErrorHelper.noResults)
        } catch {
            return Result.error(CoreDataErrorHelper.badPredicate)
        }
        
    }
    
    static func == (lhs: GenreDAO, rhs: GenreDAO) -> Bool {
        return lhs.id == rhs.id
    }
    
}
