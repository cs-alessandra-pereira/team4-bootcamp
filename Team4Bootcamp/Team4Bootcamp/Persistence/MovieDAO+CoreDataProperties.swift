//
//  MovieDAO+CoreDataProperties.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 24/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//
//

import Foundation
import CoreData


extension MovieDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDAO> {
        return NSFetchRequest<MovieDAO>(entityName: "MovieDAO")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var id: Int32
    @NSManaged public var overview: String
    @NSManaged public var posterPath: String
    @NSManaged public var title: String
    @NSManaged public var genres: NSSet?

}

// MARK: Generated accessors for genres
extension MovieDAO {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreDAO)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreDAO)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
