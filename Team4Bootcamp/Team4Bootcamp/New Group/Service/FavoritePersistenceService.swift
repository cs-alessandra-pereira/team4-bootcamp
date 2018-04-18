//
//  FavoritePersistenceService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

protocol MoviePersistenceProtocol: MoviesProtocol {
    func deleteMovie(movie: Movie)
    func addMovie(movie: Movie)
}

final class FavoritePersistenceService: MoviePersistenceProtocol {

    private var appDelegate = UIApplication.shared.delegate as! AppDelegate //swiftlint:disable:this force_cast
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //swiftlint:disable:this force_cast

    func addMovie(movie: Movie) {
        
        let newMovieDAO = MovieDAO(entity: MovieDAO.entity(), insertInto: context)
        
        newMovieDAO.date = movie.releaseDate as NSDate?
        newMovieDAO.id = Int16(movie.id)
        newMovieDAO.overview = movie.overview
        newMovieDAO.title = movie.title
        newMovieDAO.posterPath = movie.posterPath
        
        appDelegate.saveContext()
    }
    
    func fetchMovies(callback: @escaping ([Movie]) -> Void) {
        do {
            
            let movies = try self.context.fetch(MovieDAO.fetchRequest())
            guard let moviesDAO = movies as? [MovieDAO] else {
                callback([])
                return
            }
            var fetchedMovies: [Movie] = []
            for movie in moviesDAO {
                fetchedMovies.append(Movie(from: movie))
            }
            callback(fetchedMovies)
            
        } catch {
            callback([])
        }
    }
    
    func fetchGenres(callback: @escaping ([GenreId: GenreName]) -> Void) {
        
    }
    
    func deleteMovie(movie: Movie) {
    }
}
