//
//  MoviesService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

protocol MoviesServiceProtocol {
    // Como eu sei que foi um erro ?
    func fetchMovies(callback: @escaping ([Movie]) -> Void)
    // Agora eu tenho como tomar alguma acao caso venha um erro
    func fetchPosterImage(forMovie movie: Movie, callback: @escaping (FetchResult<[Movie], APIError>) -> Void)
    
    func fetchGenres(callback: @escaping (FetchResult<[(id: Int,genre: String)],APIError>) -> Void)
}

enum APIError: Error {
    case invalidData, parseError(String), customError(Error)
}
