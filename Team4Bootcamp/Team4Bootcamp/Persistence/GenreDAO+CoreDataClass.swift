//
//  GenreDAO+CoreDataClass.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 24/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//
//

import Foundation
import CoreData


public class GenreDAO: NSManagedObject {
    
    static var allGenres: [GenreId: GenreName] = [:]
    
    class func addGenres(genres: [GenreId: GenreName], context: NSManagedObjectContext) -> Set<GenreDAO> {
        
        var newGenres = Set<GenreDAO>()
        
        for (id, name) in genres {
            let newGenreDAO = GenreDAO(context: context)
            newGenreDAO.id = Int32(id)
            newGenreDAO.name = name
            newGenres.insert(newGenreDAO)
        }
        return newGenres
    }
    
    class func deleteAllGenres(context: NSManagedObjectContext) -> Result<Bool, CoreDataErrorHelper> {
        do {
            let result = try context.deleteObjects(GenreDAO.self)
            if result > 0 {
                allGenres = [:]
                return Result.success(true)
            } else {
                return Result.error(CoreDataErrorHelper.noResults)
            }
        } catch {
            return Result.error(CoreDataErrorHelper.badPredicate)
        }
    }
    
    static func == (lhs: GenreDAO, rhs: GenreDAO) -> Bool {
        return lhs.id == rhs.id
    }
}
