//
//  MovieFetchService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

class MoviesAPI {
    
    func request(endpoint: Endpoints, callback: @escaping (Result<Any, MoviesError>) -> Void) {
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

            let content = self.decodeContent(from: data, withEndpoint: endpoint)
            if let response = content.response {
                callback(.success(response))
            } else if content.error != nil {
                callback(.error(MoviesError.invalidData))
            }
            
        }
        task.resume()
    }
    
    func decodeContent(from data: Data, withEndpoint endpoint: Endpoints) -> (response: Any?, error: Error?) {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            switch endpoint {
            case .movieList:
                let decodableResponse = try decoder.decode(MovieListWrapper.self, from: data)
                return (decodableResponse, nil)
            case .genre:
                let decodableResponse = try decoder.decode(GenresWrapper.self, from: data)
                return (decodableResponse, nil)
            default:
                break
            }
        } catch {
            return (nil, MoviesError.invalidData)
        }
        return (nil, MoviesError.invalidData)
    }
}

extension MoviesAPI: MoviesProtocol {
    func fetchMovies(callback: @escaping (Result<[Movie], MoviesError>) -> Void) {
        request(endpoint: Endpoints.movieList) { result in
            
            switch result {
            case .success(let movieListJson):
                guard let movieList = movieListJson as? MovieListWrapper else {
                    DispatchQueue.main.async { callback(.error(MoviesError.invalidData)) }
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
