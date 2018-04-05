//
//  MovieFetchService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

final class MoviesAPI {
    
    fileprivate func request(endpoint: MoviesConstants.Endpoints, callback: @escaping (FetchResult<Any, APIError>) -> Void) {
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
            
            let decoder = JSONDecoder()
            
            do {
                switch endpoint {
                case .movieList:
                    let decodableResponse = try decoder.decode(MovieListWrapper.self, from: data)
                    callback(.success(decodableResponse))
                case .genre:
                    let decodableResponse = try decoder.decode(GenresWrapper.self, from: data)
                    callback(.success(decodableResponse))
                default:
                    break
                }
            } catch {
                callback(.error(APIError.parseError(error.localizedDescription)))
            }
        }
        task.resume()
    }
}

extension MoviesAPI: MoviesServiceProtocol {
    func fetchGenres(callback: @escaping ([GenreId:GenreName]) -> Void) {
        request(endpoint: MoviesConstants.Endpoints.genre) { result in
            switch result {
            case .success(let genres):
                guard let genresWrapper = genres as? GenresWrapper else {
                    DispatchQueue.main.async { callback(Genres()) }
                    return
                }
                DispatchQueue.main.async {
                    callback(genresWrapper.genreDictionary)
                    return
                }
            case .error:
                DispatchQueue.main.async {
                    callback(Genres())
                }
            }
        }
    }
    
    func fetchMovies(callback: @escaping ([Movie]) -> Void) {
        request(endpoint: MoviesConstants.Endpoints.movieList) { result in
            
            switch result {
            case .success(let movieListJson):
                guard let movieList = movieListJson as? MovieListWrapper else{
                    DispatchQueue.main.async { callback([]) }
                    return
                }
                DispatchQueue.main.async { callback(movieList.results) }
            case .error:
                DispatchQueue.main.async { callback([]) }
            }
        }
    }
}

struct MovieListWrapper: Decodable {
    let results: [Movie]
}

struct GenresWrapper: Decodable {
    
    var genreDictionary: Genres = [:]
    
    struct Genre: Decodable {
        let id: GenreId
        let name: GenreName
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case genres
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let genresList = try values.decode([Genre].self, forKey: .genres)
        for genre in genresList {
            genreDictionary[genre.id] = genre.name
        }
    }
}
/*struct MovieWrapper: Codable {
 let id: Int
 let title: String
 let release_date: String
 let genre_ids: [Int]
 let overview: String
 let poster_path: String
 }*/

/*"vote_count": 1126,
 "id": 337167,
 "video": false,
 "vote_average": 6.1,
 "title": "Fifty Shades Freed",
 "popularity": 508.881531,
 "poster_path": "/jjPJ4s3DWZZvI4vw8Xfi4Vqa1Q8.jpg",
 "original_language": "en",
 "original_title": "Fifty Shades Freed",
 "genre_ids": [
 18,
 10749
 ],
 "backdrop_path": "/9ywA15OAiwjSTvg3cBs9B7kOCBF.jpg",
 "adult": false,
 "overview": "Believing they have left behind shadowy figures from their past, newlyweds Christian and Ana fully embrace an inextricable connection and shared life of luxury. But just as she steps into her role as Mrs. Grey and he relaxes into an unfamiliar stability, new threats could jeopardize their happy ending before it even begins.",
 "release_date": "2018-02-07"
 */
