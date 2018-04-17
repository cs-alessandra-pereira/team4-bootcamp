//
//  MovieFetchService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

class MoviesAPI {
    
    func request(endpoint: Endpoints, callback: @escaping (Result<Any, APIError>) -> Void) {
        let url = URL(string: "\(MoviesConstants.baseURL)\(endpoint.path)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                callback(.error(APIError.customError(error)))
                return
            }
            guard let data = data else {
                callback(.error(APIError.invalidData))
                return
            }

            let content = self.decodeContent(from: data, withEndpoint: endpoint)
            if let response = content.response {
                callback(.success(response))
            } else if let error = content.error {
                callback(.error(APIError.parseError(error.localizedDescription)))
            }
            
        }
        task.resume()
    }
    
    func decodeContent(from data: Data, withEndpoint endpoint: Endpoints) -> (response: Any?, error: Error?) {
        
        let decoder = JSONDecoder()
        
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
            return (nil, error)
        }
        return (nil, APIError.invalidData)
    }
}

extension MoviesAPI: MoviesProtocol {
    func fetchGenres(callback: @escaping ([GenreId: GenreName]) -> Void) {
        request(endpoint: Endpoints.genre) { result in
            switch result {
            case .success(let genres):
                guard let genresWrapper = genres as? GenresWrapper else {
                    DispatchQueue.main.async { callback([GenreId: GenreName]()) }
                    return
                }
                DispatchQueue.main.async {
                    callback(genresWrapper.genreDictionary)
                    return
                }
            case .error:
                DispatchQueue.main.async {
                    callback([GenreId: GenreName]())
                }
            }
        }
    }
    
    func fetchMovies(callback: @escaping ([Movie]) -> Void) {
        request(endpoint: Endpoints.movieList) { result in
            
            switch result {
            case .success(let movieListJson):
                guard let movieList = movieListJson as? MovieListWrapper else {
                    DispatchQueue.main.async { callback([]) }
                    return
                }
                DispatchQueue.main.async { callback(movieList.results) }
            case .error:
                DispatchQueue.main.async {
                    //FIXME: Tales - vale um tratamento de erros melhor - o que acontece numa busca vazia? timout?
                    callback([]) }
            }
        }
    }
}
