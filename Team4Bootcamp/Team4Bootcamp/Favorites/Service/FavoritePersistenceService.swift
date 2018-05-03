//
//  FavoritePersistenceService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

final class FavoritePersistenceService {
    
    func fetchMovies(context: NSManagedObjectContext, callback: @escaping (Result<[Movie], MoviesError>) -> Void) {
        do {
            let movies = try context.fetch(MovieDAO.fetchRequest())
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
    
    func fetchGenres(callback: @escaping (Result<[GenreId: GenreName], MoviesError>) -> Void) {
    }
}
