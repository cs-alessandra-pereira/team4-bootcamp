//
//  MoviePredicates.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 20/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

enum MovieDAOPredicates {
    
    case yearFiltering([String])
    case genreFiltering([String])
    case titleSearch(String)
    case idSelection(Movie)
    
    var predicate: NSPredicate {
        switch self {
        case .yearFiltering(let years):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var predicates = [NSPredicate]()
            for year in years {
                let startDate = dateFormatter.date(from: "\(year)-01-01")
                let endDate = dateFormatter.date(from: "\(year)-12-31")
                if let start = startDate, let end = endDate {
                    let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", start as NSDate, end as NSDate)
                    predicates.append(predicate)
                }
            }
            return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        case .genreFiltering(let genres):
            return NSPredicate(format: "ANY genres.name IN %@", genres)
        case .titleSearch(let title):
            return NSPredicate(format: "title BEGINSWITH[c] %@", title)
        case .idSelection(let movie):
            return  NSPredicate(format: "id == \(movie.id)")
        }
    }
}
