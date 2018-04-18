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
    var releaseDate: Date?
    var genres: [Genre]
    let overview: String
    let posterPath: String
    var persisted: Bool
    
    static let moviePersistentceService: MoviePersistenceProtocol = FavoritePersistenceService()
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case genresIDs = "genre_ids"
        case overview
        case posterPath = "poster_path"
    }
    
    func genresNameAsString() -> String {
        let genreList = Genre.allGenres
        var genresNames: String = ""
        for genre in genres {
            if let name = genreList[genre.id] {
                genresNames += "\(name), "
            }
        }
        let indexToRemove = genresNames.index(genresNames.endIndex, offsetBy: -1)
        genresNames.remove(at: genresNames.index(before: indexToRemove))
        return genresNames
    }
    
    func releaseYearAsString(releaseDate: Date?) -> String {
        guard let date = releaseDate else {
            return ""
        }
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let dateString = yearFormatter.string(from: date)
        return dateString
    }
}

extension Movie {
    init(from movieDAO: MovieDAO) {
        let date = movieDAO.date as Date?
        id = Int(movieDAO.id)
        title = movieDAO.title
        overview = movieDAO.overview
        posterPath = movieDAO.posterPath
        genres = []
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
        let genreIDs = try values.decode([Int].self, forKey: .genresIDs)
        var genres: [Genre] = []
        for id in genreIDs {
            genres.append(Genre(id: id))
        }
        self.genres = genres
        
        persisted = Movie.moviePersistentceService.previouslyInserted(movieId: id)
    }
}
