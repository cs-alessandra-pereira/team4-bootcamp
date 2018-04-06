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

struct Genre: Decodable {
    
    let id: Int
    var name: String
    
    init(id: Int) {
        self.id = id
        self.name = ""
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
