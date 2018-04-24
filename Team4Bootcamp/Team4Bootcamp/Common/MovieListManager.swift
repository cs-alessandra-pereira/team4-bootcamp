//
//  MovieListManager.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 24/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

//
//  MovieListManagerProtocol.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 23/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

protocol MovieListManager: class {
    var movies: [Movie] { get set}
    func getMovies() -> [Movie]
    func addMovies(newMovies: [Movie])
    func getMovieIndex(movie: Movie) -> Int?
    func getMovieCount() -> Int
}

extension MovieListManager {
    
    func getMovies() -> [Movie] {
        return movies
    }
    
    func addMovies(newMovies: [Movie]) {
        movies += newMovies
    }
    
    func getMovieIndex(movie: Movie) -> Int? {
        var index = 0
        for element in movies {
            if element.id == movie.id {
                return index
            }
            index += 1
        }
        return nil
    }
    
    func getMovieCount() -> Int {
        return movies.count
    }
}
