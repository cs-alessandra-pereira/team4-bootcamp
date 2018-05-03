//
//  MovieListManager.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 24/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

protocol MovieListManager: class {
    associatedtype Item: Equatable
    var movies: [Item] { get set}
    func getMovies() -> [Item]
    func addMovies(newMovies: [Item])
    func getMovieIndex(movie: Item) -> Int?
    func getMovieCount() -> Int
}

extension MovieListManager {
    
    func getMovies() -> [Item] {
        return movies
    }
    
    func addMovies(newMovies: [Item]) {
        movies += newMovies
    }
    
    func getMovieIndex(movie: Item) -> Int? {
        var index = 0
        for element in movies {
            if element == movie {
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
