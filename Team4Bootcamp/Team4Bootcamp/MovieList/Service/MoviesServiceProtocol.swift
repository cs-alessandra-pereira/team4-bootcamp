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
    func fetchGenres(callback: @escaping ([GenreId:GenreName]) -> Void)
}

enum APIError: Error {
    case invalidData, parseError(String), customError(Error)
}
