//
//  MovieDAO+CoreDataClass.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 18/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//
//

import Foundation
import CoreData


class MovieDAO: NSManagedObject {
    
    class func previouslyInserted(movieId: Int, context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<MovieDAO> =  MovieDAO.fetchRequest()
        request.predicate = NSPredicate(format: "id == \(movieId)")
        
        do {
            let existingMovies = try context.fetch(request)
            return existingMovies.count == 0 ? false : true
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return false
    }
    
    class func addMovie(movie: Movie, context: NSManagedObjectContext) -> Bool {
        if previouslyInserted(movieId: movie.id, context: context) == false {
            let newMovieDAO = MovieDAO(context: context)
            newMovieDAO.date = movie.releaseDate as NSDate?
            newMovieDAO.id = Int32(movie.id)
            newMovieDAO.overview = movie.overview
            newMovieDAO.title = movie.title
            newMovieDAO.posterPath = movie.posterPath
            newMovieDAO.genres = []
            for gnr in movie.genres {
                newMovieDAO.genres.append(gnr.id)
            }
            try? context.save()
            return true
        }
        return false
    }
    
    class func deleteMovie(movie: Movie, context: NSManagedObjectContext) -> Bool {
        let request: NSFetchRequest<MovieDAO> = MovieDAO.fetchRequest()
        request.predicate = NSPredicate(format: "id == \(movie.id)")
        if let results = try? context.fetch(request) {
            if results.count > 0 {
                context.delete(results[0])
                return true
            }
        }
        return false
    }
    
    static func == (lhs: MovieDAO, rhs: MovieDAO) -> Bool {
        return lhs.id == rhs.id
    }
    
}


