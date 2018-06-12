//
//  Movie.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 27/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import CoreData

struct Movie {
    
    let id: Int
    let title: String
    var releaseDate: Date?
    var genresIds: [GenreId]
    let overview: String
    let posterPath: String
    var persisted = false
    
    static let moviePersistentceService = FavoritePersistenceService()
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case genresIDs = "genre_ids"
        case overview
        case posterPath = "poster_path"
    }
    
    func genresNameAsString(container: NSPersistentContainer?) -> String {
        
        var genresNames: String = ""
        
        let genreList = GenreDAO.allGenres
        
        for id in genresIds {
            if let matchingGenre = genreList[id] {
                genresNames += "\(matchingGenre), "
            }
        }
        if genreList.count > 0 {
            let indexToRemove = genresNames.index(genresNames.endIndex, offsetBy: -1)
            genresNames.remove(at: genresNames.index(before: indexToRemove))
            return genresNames
        } else {
            return "No data"
        }
    }
    
    func releaseYearAsString() -> String {
        guard let date = releaseDate, let year = Calendar.current.dateComponents([.year], from: date).year else {
            return "Unknown"
        }
        return "\(year)"
    }
}

extension Movie {
    init(from movieDAO: MovieDAO) {
        let date = movieDAO.date as Date?
        id = Int(movieDAO.id)
        title = movieDAO.title
        overview = movieDAO.overview
        posterPath = movieDAO.posterPath
        genresIds = []
        
        if let genres = movieDAO.genres?.allObjects as? [GenreDAO] {
            for genre in genres {
                genresIds.append(Int(genre.id))
            }
        }
           
        releaseDate = date
        persisted = true
    }
}

extension Movie: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        overview = try values.decode(String.self, forKey: .overview)
        posterPath = try values.decode(String.self, forKey: .posterPath)
        
        do {
            let dateString = try values.decode(String.self, forKey: .releaseDate)
            releaseDate = Date.getDateFromString(dateString: dateString)
        } catch {
            releaseDate = nil
        }
        genresIds = try values.decode([Int].self, forKey: .genresIDs)
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
