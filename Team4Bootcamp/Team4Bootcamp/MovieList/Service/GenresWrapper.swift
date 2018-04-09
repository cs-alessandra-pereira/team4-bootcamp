//
//  GenresWrapper.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 09/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

struct GenresWrapper: Decodable {
    
    var genreDictionary: [GenreId: GenreName] = [:]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
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
