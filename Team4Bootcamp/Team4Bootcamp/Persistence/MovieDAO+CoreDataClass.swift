//
//  MovieDAO+CoreDataClass.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 24/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//
//

import Foundation
import CoreData


public class MovieDAO: NSManagedObject {
    
    @discardableResult
    class func addMovie(movie: Movie, context: NSManagedObjectContext) -> Result<MovieDAO, CoreDataErrorHelper> {
        do {

            let previouslyInserted = try wasPreviouslyInserted(movie: movie, context: context)
            
            if previouslyInserted == false {
                let newMovieDAO = MovieDAO(context: context)
                newMovieDAO.date = movie.releaseDate as NSDate?
                newMovieDAO.id = Int32(movie.id)
                newMovieDAO.overview = movie.overview
                newMovieDAO.title = movie.title
                newMovieDAO.posterPath = movie.posterPath
                
                var newGenresDict = [GenreId: GenreName]()
                for id in movie.genresIds {
                    newGenresDict[id] = GenreDAO.allGenres[id]
                }
                let newGenresDAO = GenreDAO.addGenres(genres: newGenresDict, context: context) as NSSet
                newMovieDAO.addToGenres(newGenresDAO)
                
                try? context.save()
                return Result.success(newMovieDAO)
            }
            return Result.error(CoreDataErrorHelper.duplicateEntry)
        } catch {
            return Result.error(CoreDataErrorHelper.badPredicate)
        }
    }
    
    @discardableResult
    class func deleteMovie(context: NSManagedObjectContext, movie: Movie) -> Result<Bool, CoreDataErrorHelper> {
        do {
            let predicate = MovieDAOPredicates.idSelection(movie).predicate
            let result = try context.deleteObjects(MovieDAO.self, predicate: predicate)
            return result > 0 ? Result.success(true) : Result.error(CoreDataErrorHelper.noResults)
        } catch {
            return Result.error(CoreDataErrorHelper.badPredicate)
        }
    }
    
    static func == (lhs: MovieDAO, rhs: MovieDAO) -> Bool {
        return lhs.id == rhs.id
    }
    
    class func wasPreviouslyInserted(movie: Movie, context: NSManagedObjectContext) throws -> Bool {
        let predicate = MovieDAOPredicates.idSelection(movie).predicate
        return try context.previouslyInserted(MovieDAO.self, predicateForDuplicityCheck: predicate)
    }
    
    class func searchMoviesFrom(years: [String], context: NSManagedObjectContext) -> Result<[MovieDAO], CoreDataErrorHelper > {
        
        let compoundPredicates = MovieDAOPredicates.yearFiltering(years).predicate
        let request = context.buildNSFetchRequest(forClass: MovieDAO.self, predicate: compoundPredicates)
        if let results = try? context.fetchObjects(withRequest: request) {
            return Result.success(results)
        }
        
        return Result.error(CoreDataErrorHelper.badPredicate)
    }
    
    class func searchMoviesFromGenres(genres: [String], context: NSManagedObjectContext) -> Result<[MovieDAO], CoreDataErrorHelper > {
        
        var moviesDAOFetched = [MovieDAO]()
        let predicate = MovieDAOPredicates.genreFiltering(genres).predicate
        let request = context.buildNSFetchRequest(forClass: GenreDAO.self, predicate: predicate)
        if let results = try? context.fetchObjects(withRequest: request) {
            for result in results {
                if let movie = result.movies {
                    moviesDAOFetched.append(movie)
                }
            }
            return Result.success(moviesDAOFetched)
        }
        
        return Result.error(CoreDataErrorHelper.badPredicate)
    }
}
