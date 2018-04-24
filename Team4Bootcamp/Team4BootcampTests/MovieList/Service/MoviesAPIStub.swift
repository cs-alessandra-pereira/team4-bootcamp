//
//  MovieAPIStub.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 07/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
@testable import Team4Bootcamp

class MoviesAPIStub: MoviesAPI {
    
    var genreWasParsed = false
    var movieWasParsed = false
    
    let genreJsonString = """
        {"genres":[{"id":28,"name":"Action"},{"id":12,"name":"Adventure"},{"id":16,"name":"Animation"},{"id":35,"name":"Comedy"},{"id":80,"name":"Crime"},{"id":99,"name":"Documentary"},{"id":18,"name":"Drama"},{"id":10751,"name":"Family"},{"id":14,"name":"Fantasy"},{"id":36,"name":"History"},{"id":27,"name":"Horror"},{"id":10402,"name":"Music"},{"id":9648,"name":"Mystery"},{"id":10749,"name":"Romance"},{"id":878,"name":"Science Fiction"},{"id":10770,"name":"TV Movie"},{"id":53,"name":"Thriller"},{"id":10752,"name":"War"},{"id":37,"name":"Western"}]}
        """
    
    
    
    let movieListJsonString = """
            {"page":1,"total_results":19878,"total_pages":994,"results":[{"vote_count":1270,"id":337167,"video":false,"vote_average":6.1,"title":"Fifty Shades Freed","popularity":571.872729,"poster_path":"/jjPJ4s3DWZZvI4vw8Xfi4Vqa1Q8.jpg","original_language":"en","original_title":"Fifty Shades Freed","genre_ids":[18,10749],"backdrop_path":"/iuyE1qy9HoTsMg0DHB1KJxM94DJ.jpg","adult":false,"overview":"Believing they have left behind shadowy figures from their past, newlyweds Christian and Ana fully embrace an inextricable connection and shared life of luxury. But just as she steps into her role as Mrs. Grey and he relaxes into an unfamiliar stability, new threats could jeopardize their happy ending before it even begins.","release_date":"2018-02-07"},{"vote_count":6837,"id":269149,"video":false,"vote_average":7.7,"title":"Zootopia","popularity":392.838366,"poster_path":"/sM33SANp9z6rXW8Itn7NnG1GOEs.jpg","original_language":"en","original_title":"Zootopia","genre_ids":[16,12,10751,35],"backdrop_path":"/mhdeE1yShHTaDbJVdWyTlzFvNkr.jpg","adult":false,"overview":"Determined to prove herself, Officer Judy Hopps, the first bunny on Zootopia's police force, jumps at the chance to crack her first case - even if it means partnering with scam-artist fox Nick Wilde to solve the mystery.","release_date":"2016-02-11"},{"vote_count":3686,"id":354912,"video":false,"vote_average":7.8,"title":"Coco","popularity":311.848958,"poster_path":"/eKi8dIrr8voobbaGzDpe8w0PVbC.jpg","original_language":"en","original_title":"Coco","genre_ids":[12,35,10751,16],"backdrop_path":"/askg3SMvhqEl4OL52YuvdtY40Yb.jpg","adult":false,"overview":"Despite his family’s baffling generations-old ban on music, Miguel dreams of becoming an accomplished musician like his idol, Ernesto de la Cruz. Desperate to prove his talent, Miguel finds himself in the stunning and colorful Land of the Dead following a mysterious chain of events. Along the way, he meets charming trickster Hector, and together, they set off on an extraordinary journey to unlock the real story behind Miguel's family history.","release_date":"2017-10-27"}]}
            """
    
    override func request(endpoint: Endpoints, callback: @escaping (Result<Any, MoviesError>) -> Void) {
        
        switch endpoint {
            
        case .genre:
           
                let stringData = genreJsonString.data(using: .utf8)
                let content = decodeContent(from: stringData!, withEndpoint: .genre)
                if let response = content.response, response as? GenresWrapper != nil {
                    genreWasParsed = true
                }
            
        case .movieList:
                let stringData = movieListJsonString.data(using: .utf8)
                let content = decodeContent(from: stringData!, withEndpoint: .movieList)
                if let response = content.response, response as? MovieListWrapper != nil {
                    movieWasParsed = true
                }
            
        default:
            break
        }
    }
}
