//
//  PersistenceConstants.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

struct PersistenceConstants {
    static let persistenceContainerName = "Team4Bootcamp"
    static let notificationUserInfoKey = "movie"
}

extension Notification.Name {
    static let movieAddedToPersistence = Notification.Name("movie_added_to_persistence")
    static let movieRemovedFromPersistence = Notification.Name("movie_removed_from_persistence")
}
