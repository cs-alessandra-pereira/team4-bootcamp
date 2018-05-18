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

    class func previouslyInserted(genreId: Int, context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<GenreDAO> =  GenreDAO.fetchRequest()
        request.predicate = NSPredicate(format: "id == \(genreId)")
        
        do {
            let existingMovies = try context.fetch(request)
            return existingMovies.count == 0 ? false : true
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return false
    }
    
    class func addGenres(genres: [GenreId: GenreName], context: NSManagedObjectContext) {
        for (id, name) in genres {
            if previouslyInserted(genreId: id, context: context) == false {
                let newGenreDAO = GenreDAO(context: context)
                newGenreDAO.id = Int32(id)
                newGenreDAO.name = name
                //newGenreDAO.movies = try? MovieDAO.findOrCreateTwitterUser(matching: genre.id, in: context)
            }
        }
        try? context.save()
    }
    
    class func deleteGenre(genre: Genre, context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<GenreDAO> = GenreDAO.fetchRequest()
        request.predicate = NSPredicate(format: "id == \(genre.id)")
        if let results = try? context.fetch(request) {
            if let result = results.first {
                context.delete(result)
                return true
            }
        }
        return false
    }
    
    static func == (lhs: GenreDAO, rhs: GenreDAO) -> Bool {
        return lhs.id == rhs.id
    }
    
}
