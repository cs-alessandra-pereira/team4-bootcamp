//
//  Endpoints.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 13/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

enum Endpoint {
    
    case movieList
    case moviePoster(String)
    case genre
    
    var path: String {
        switch self {
        case .movieList:
            return "movie/popular?api_key=\(APIConstants.apiKey)&language=en-US&page=\(APIConstants.pageBaseURL)"
        case .genre:
            return "genre/movie/list?api_key=\(APIConstants.apiKey)&language=en-US"
        case .moviePoster(let posterPath):
            return "\(APIConstants.imgBaseURL)\(posterPath)"
        }
    }
    
    var method: Methods {
        switch self {
        case .movieList:
            return .GET
        case .genre:
            return .GET
        case .moviePoster:
            return .GET
        }
    }
    
    var url: URL {
        return URL(string: "\(APIConstants.baseURL)\(self.path)")!
    }
    
    func request(_ headers: [String: String]? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        return request as URLRequest
    }
    
    func decode(_ data: Data) -> Decodable? {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            switch self {
            case .genre:
                return try decoder.decode(GenresWrapper.self, from: data)
            case .movieList:
                return try decoder.decode(MovieListWrapper.self, from: data)
            default:
                return nil
            }
        } catch {
            return nil
        }
    }
    
    enum Methods: String {
        case GET
        case POST
    }
}
