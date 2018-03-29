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

    enum Endpoints {
        case movieList
        case moviePoster
        case genre
        
        var path: String {
            switch self {
            case .movieList:
                return "movie/popular?api_key=\(MoviesConstants.apiKey)&language=en-US&page=1"
            case .genre:
                return ""
            case .moviePoster:
                return ""
            }
        }
    }
}
