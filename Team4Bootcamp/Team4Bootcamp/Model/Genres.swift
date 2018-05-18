//
//  Genre.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 27/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

typealias GenreName = String
typealias GenreId = Int

struct Genre {
    static var allGenres: [GenreId: GenreName] = [:]
    
    let id: Int
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(id: Int) {
        self.id = id
        self.name = ""
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension Genre {
    init(from genreDAO: GenreDAO) {
        id = Int(genreDAO.id)
        name = genreDAO.name
    }
}

extension Genre: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        
    }
}

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}
