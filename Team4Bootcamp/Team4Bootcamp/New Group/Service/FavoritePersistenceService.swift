//
//  FavoritePersistenceService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

protocol MoviePersistenceProtocol: MoviesProtocol {
    func deleteMovie(movie: Movie) -> Bool
    func addMovie(movie: Movie) -> Bool
    func previouslyInserted(movieId: Int) -> Bool
}

final class FavoritePersistenceService: MoviePersistenceProtocol {
    func fetchMovies(callback: @escaping (Result<[Movie], MoviesError>) -> Void) {
        do {
            
            let movies = try self.context.fetch(MovieDAO.fetchRequest())
            guard let moviesDAO = movies as? [MovieDAO] else {
                callback(.error(MoviesError.invalidData))
                return
            }
            
            var movieModelList: [Movie] = []
            for movieDAO in moviesDAO {
                movieModelList.append(Movie(from: movieDAO))
            }
            callback(.success(movieModelList))
            
        } catch {
            callback(.error(MoviesError.invalidData))
        }
    }
    
    func fetchGenres(callback: @escaping (Result<[GenreId : GenreName], MoviesError>) -> Void) {
    }
    

    private var appDelegate = UIApplication.shared.delegate as! AppDelegate //swiftlint:disable:this force_cast
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //swiftlint:disable:this force_cast

    func addMovie(movie: Movie) -> Bool {
        
        if previouslyInserted(movieId: movie.id) == false {
            let newMovieDAO = MovieDAO(entity: MovieDAO.entity(), insertInto: context)
            newMovieDAO.date = movie.releaseDate as NSDate?
            newMovieDAO.id = Int32(movie.id)
            newMovieDAO.overview = movie.overview
            newMovieDAO.title = movie.title
            newMovieDAO.posterPath = movie.posterPath
            appDelegate.saveContext()
            return true
        }
        return false
    }
    
    func deleteMovie(movie: Movie) -> Bool {
        let request = MovieDAO.fetchRequest() as NSFetchRequest<MovieDAO>
        request.predicate = NSPredicate(format: "id == \(movie.id)")
        if let results = try? context.fetch(request) {
            if results.count > 0 {
                context.delete(results[0])
                appDelegate.saveContext()
                return true
            }
        }
        return false
    }
    
    func previouslyInserted(movieId: Int) -> Bool {
        
        let request = MovieDAO.fetchRequest() as NSFetchRequest<MovieDAO>
        request.predicate = NSPredicate(format: "id == \(movieId)")
        
        do {
            let existingMovies = try context.fetch(request)
            return existingMovies.count == 0 ? false : true
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return true
    }
}
