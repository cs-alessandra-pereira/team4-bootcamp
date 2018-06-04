//
//  GenreDAO+CoreDataProperties.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 24/05/18.
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
    @NSManaged public var movies: MovieDAO?

}
