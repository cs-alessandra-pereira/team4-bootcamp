//
//  MoviesService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

protocol MoviesProtocol {
    func fetchMovies(callback: @escaping (Result<[Movie], MoviesError>) -> Void)
    func fetchGenres(callback: @escaping (Result<[GenreId: GenreName], MoviesError>) -> Void)
}

enum MoviesError: Error {
    case invalidData, noConection, noData, customError(Error)
}
