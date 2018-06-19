//
//  MovieFetchService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

class MoviesAPI: MoviesProtocol {
    func fetchMovies(callback: @escaping (Result<[Movie], MoviesError>) -> Void) {
        let connection: Connectable = Connection(endpoint: .movieList)
        connection.makeRequest { result in
            switch result {
            case .success(let data):
                guard let decoded = connection.endpoint.decode(data), let movieList = decoded as? MovieListWrapper else {
                    callback(.error(MoviesError.invalidData))
                    return
                }
                if APIConstants.pageBaseURL <= APIConstants.paginationLimit {
                    APIConstants.pageBaseURL += 1
                }
                DispatchQueue.main.async { callback(.success(movieList.results)) }
            case .error:
                DispatchQueue.main.async { callback(.error(MoviesError.noConection)) }
            }
        }
    }
    
    func fetchGenres(callback: @escaping (Result<[GenreId: GenreName], MoviesError>) -> Void) {
        let connection: Connectable = Connection(endpoint: .genre)
        connection.makeRequest { result in
            switch result {
            case .success(let data):
                guard let decoded = connection.endpoint.decode(data), let genres = decoded as? GenresWrapper else {
                    callback(.error(MoviesError.invalidData))
                    return
                }
                DispatchQueue.main.async { callback(.success(genres.genreDictionary)) }
            case .error:
                DispatchQueue.main.async { callback(.error(MoviesError.noConection)) }
            }
        }
    }
}
