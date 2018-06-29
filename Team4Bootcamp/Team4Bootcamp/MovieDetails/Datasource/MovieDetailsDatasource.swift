//
//  MovieDetailsDatasource.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 05/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailsDatasource: NSObject, UITableViewDataSource {
    
    var info: [String]
    
    init(tableView: UITableView, movie: Movie) {
        self.info = [movie.title, Date.releaseYearAsString(movie.releaseDate), movie.genresNameAsString(container: MovieDetailsViewController.container), movie.overview]
        super.init()
        tableView.register(UITableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath)
        cell.textLabel!.text = info[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
