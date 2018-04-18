//
//  MovieDAO+CoreDataProperties.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 18/04/18.
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

}
