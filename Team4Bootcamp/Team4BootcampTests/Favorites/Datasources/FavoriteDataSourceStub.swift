//
//  FavoriteDataSourceStub.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 24/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

@testable import Team4Bootcamp
import UIKit
import CoreData

class FavoritesDataSourceStub: FavoritesDataSource {

    var numberOfMovies = 0
    
    override init(tableView: UITableView, fetchedResults: NSFetchedResultsController<MovieDAO>, searchBarDelegate: SearchBarDelegate?) {
        super.init(tableView: tableView, fetchedResults: fetchedResults, searchBarDelegate: searchBarDelegate)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfMovies = 20
        return super .tableView(tableView, numberOfRowsInSection: section)
    }
    
}
