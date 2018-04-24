//
//  FavoriteDataSourceStub.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 24/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

@testable import Team4Bootcamp
import UIKit

class FavoritesDataSourceStub: FavoritesDataSource {

    var numberOfMovies = 0
    var cell = UITableViewCell()
    var fetchedMovies: [Movie] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfMovies = 20
        return super .tableView(tableView, numberOfRowsInSection: section)
    }
    
}
