//
//  Constants.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

struct MoviesConstants {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let apiKey = "4ffd9f3fe663db609ed457cca5ab2f4e"
    static let imgBaseURL = "https://image.tmdb.org/t/p/w500"
    static let paginationLimit = 852
    static var pageBaseURL = 1
}

enum Endpoints {
    
    case movieList
    case moviePoster(String)
    case genre
    
    var path: String {
        switch self {
        case .movieList:
            return "movie/popular?api_key=\(MoviesConstants.apiKey)&language=en-US&page=\(MoviesConstants.pageBaseURL)"
        case .genre:
            return "genre/movie/list?api_key=\(MoviesConstants.apiKey)&language=en-US"
        case .moviePoster(let posterPath):
            return "\(MoviesConstants.imgBaseURL)\(posterPath)"
        }
    }
    
    func decode(_ data: Data) throws -> Decodable {
       
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        switch self {
        case .genre:
            return try decoder.decode(GenresWrapper.self, from: data)
        case .movieList:
            return try decoder.decode(MovieListWrapper.self, from: data)
        default:
            throw MoviesError.invalidData
        }
    }
}
