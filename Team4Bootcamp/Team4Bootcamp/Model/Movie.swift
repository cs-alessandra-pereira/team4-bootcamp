//
//  Movie.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 27/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

struct Movie {
    
    let id: Int
    let title: String
    let releaseDate: Date
    var genres: [Genre]
    let overview: String
    let posterPath: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case genresIDs = "genre_ids"
        case overview
        case posterPath = "poster_path"
    }
}

extension Movie: Decodable {
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        posterPath = try values.decode(String.self, forKey: .posterPath)
        
        let dateString = try values.decode(String.self, forKey: .releaseDate)
        
        let asd = dateString.split(separator: "-")
        
        let genreIDs = try values.decode([Int].self, forKey: .genresIDs)
        var genres: [Genre] = []
        for id in genreIDs {
            genres.append(Genre(id: id))
        }
        self.genres = genres

        
        //TO_DO - Convert to proper date
        releaseDate = Date()
    }
}
