//
//  MovieDetailsDatasource.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 05/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class MovieDetailsDatasource: NSObject, UITableViewDataSource {
    let movie: Movie
    var info: [Any]
    
    init(tableView: UITableView, movie: Movie) {
        self.movie = movie
        self.info = [movie.title, movie.releaseYearAsString(), movie.genresNameAsString(), movie.overview]
        super.init()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: MovieDetailsView.movieDetailsCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsView.movieDetailsCell, for: indexPath as IndexPath)
        
        let data = info[indexPath.row]
        switch data {
        case is String:
            cell.textLabel!.text = data as? String
        case is Int:
            cell.textLabel!.text = "\(data)"
        default:
            cell.textLabel!.text = "Error"
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
