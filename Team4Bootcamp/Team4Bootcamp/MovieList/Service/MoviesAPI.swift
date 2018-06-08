//
//  MovieFetchService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

class MoviesAPI {
    
    func request(endpoint: Endpoints, callback: @escaping (Result<Decodable, MoviesError>) -> Void) {
        let url = URL(string: "\(MoviesConstants.baseURL)\(endpoint.path)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                callback(.error(MoviesError.noConection))
                return
            }
            guard let data = data else {
                callback(.error(MoviesError.invalidData))
                return
            }
            
            do {
                callback(.success(try endpoint.decode(data)))
            } catch {
                callback(.error(MoviesError.noData))
            }
        }
        task.resume()
    }
}

extension MoviesAPI: MoviesProtocol {

    func fetchMovies(callback: @escaping (Result<[Movie], MoviesError>) -> Void) {
        request(endpoint: Endpoints.movieList) { result in
            
            switch result {
            case .success(let movieListJson):
                guard let movieList = movieListJson as? MovieListWrapper else {
                    DispatchQueue.main.async { callback(.error(MoviesError.noData)) }
                    return
                }
                if MoviesConstants.pageBaseURL <= MoviesConstants.paginationLimit {
                    MoviesConstants.pageBaseURL += 1
                }
                DispatchQueue.main.async { callback(.success(movieList.results)) }
            case .error(let err):
                DispatchQueue.main.async {
                    callback(.error(err)) }
            }
        }
    }
    
    func fetchGenres(callback: @escaping (Result<[GenreId: GenreName], MoviesError>) -> Void) {
        request(endpoint: Endpoints.genre) { result in
            switch result {
            case .success(let genres):
                guard let genresWrapper = genres as? GenresWrapper else {
                    DispatchQueue.main.async { callback(.error(MoviesError.invalidData)) }
                    return
                }
                DispatchQueue.main.async {
                    callback(.success(genresWrapper.genreDictionary))
                    return
                }
            case .error(let err):
                DispatchQueue.main.async {
                    callback(.error(err))
                }
            }
        }
    }
}
