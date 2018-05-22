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
    
    class func addMovie(movie: Movie, context: NSManagedObjectContext) -> Result<Bool, CoreDataErrorHelper> {
        do {
            let predicate = NSPredicate(format: "id == \(movie.id)")
            let previouslyInserted = try context.previouslyInserted(MovieDAO.self, predicateForDuplicityCheck: predicate)
            
            if previouslyInserted == false {
                let newMovieDAO = MovieDAO(context: context)
                newMovieDAO.date = movie.releaseDate as NSDate?
                newMovieDAO.id = Int32(movie.id)
                newMovieDAO.overview = movie.overview
                newMovieDAO.title = movie.title
                newMovieDAO.posterPath = movie.posterPath
                newMovieDAO.genresId = []
                for gnr in movie.genresIds {
                    newMovieDAO.genresId.append(gnr.id)
                }
                try? context.save()
                return Result.success(true)
            }
            return Result.error(CoreDataErrorHelper.duplicateEntry)
        } catch {
            return Result.error(CoreDataErrorHelper.badPredicate)
        }
    }
    
    class func deleteMovie(movie: Movie, context: NSManagedObjectContext, predicate: NSPredicate) -> Result<Bool, CoreDataErrorHelper> {
        do {
            let predicate = predicate
            let result = try context.deleteObjects(MovieDAO.self, predicate: predicate)
            return result > 0 ? Result.success(true) : Result.error(CoreDataErrorHelper.noResults)
        } catch {
            return Result.error(CoreDataErrorHelper.badPredicate)
        }
    }
    
    static func == (lhs: MovieDAO, rhs: MovieDAO) -> Bool {
        return lhs.id == rhs.id
    }
    
    class func searchMoviesFrom(years: [String], context: NSManagedObjectContext) -> Result<[MovieDAO], CoreDataErrorHelper > {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var predicates = [NSPredicate]()
        for year in years {
            let startDate = dateFormatter.date(from: "\(year)-01-01")
            let endDate = dateFormatter.date(from: "\(year)-12-31")
            if let start = startDate, let end = endDate {
                let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", start as NSDate, end as NSDate)
                predicates.append(predicate)
            }
        }
        
        let compoundPredicates = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        if let results = try? context.fetchObjects(MovieDAO.self, predicate: compoundPredicates) {
            return Result.success(results)
        }

        return Result.error(CoreDataErrorHelper.badPredicate)
    }
    
}
