//
//  MovieFetchService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

final class MoviesAPI {
    
    fileprivate func request(endpoint: MoviesConstants.Endpoints, callback: @escaping (FetchResult<MovieListWrapper, APIError>) -> Void) {
        let endpoint = URL(string: "\(MoviesConstants.baseURL)\(endpoint.path)")!
        let request = URLRequest(url: endpoint)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                callback(.error(APIError.customError(error)))
                return
            }
            guard let data = data else {
                callback(.error(APIError.invalidData))
                return
            }
            //TO-DO - Testar API Key inválida (success = false)
            let decoder = JSONDecoder()
            do {
                let decodableResponse = try decoder.decode(MovieListWrapper.self, from: data)
                callback(.success(decodableResponse))
            } catch {
                callback(.error(APIError.parseError(error.localizedDescription)))
            }
        }
        task.resume()
    }
}

extension MoviesAPI: MoviesServiceProtocol {
    //FIXME: Tales - não faz paginação? apenas a primeira pagina de dados na request...
    // `page=1` no endpoint `movieList`
    func fetchMovies(callback: @escaping ([Movie]) -> Void) {
        request(endpoint: MoviesConstants.Endpoints.movieList) { result in
            switch result {
            case .success(let movieListJson):
                let movies = movieListJson.results.map { Movie(id: $0.id, title: $0.title, releaseDate: $0.release_date, genresIds: $0.genre_ids, overview: $0.overview, posterPath: $0.poster_path) }
                DispatchQueue.main.async {
                    callback(movies)
                }
            case .error:
                DispatchQueue.main.async {
                    //FIXME: Tales - vale um tratamento de erros melhor - o que acontece numa busca vazia? timout?
                    callback([])
                }
            }
        }
    }
    
    func fetchPosterImage(forMovie movie: Movie, callback: @escaping (FetchResult<[Movie], APIError>) -> Void) {
        //FIXME: Tales - método não usado ou não implementado? Se desnecessario, remover - mantenha o código limpo
    }
}

//FIXME: Tales - mover para outro arquivo, organização do código
struct MovieListWrapper: Codable {
    //let success: Bool
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [MovieWrapper]
}
struct MovieWrapper: Codable {
    let id: Int
    let title: String
    let release_date: String
    let genre_ids: [Int]
    let overview: String
    let poster_path: String
}
//FIXME: Tales - evitem deixar comentários assim no código
// fizeram pensando em testes? projeto não tem testes...
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
