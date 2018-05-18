//
//  GenreDAO+CoreDataProperties.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 17/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//
//

import Foundation
import CoreData


extension GenreDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreDAO> {
        return NSFetchRequest<GenreDAO>(entityName: "GenreDAO")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension GenreDAO {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieDAO)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieDAO)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
