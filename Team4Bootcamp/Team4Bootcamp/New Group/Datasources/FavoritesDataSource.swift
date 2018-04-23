//
//  FavoritesDataSource.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class FavoritesDataSource: NSObject, UITableViewDataSource {
    
    private let tableView: UITableView
    
    var favoriteMovies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(movies: [Movie], tableView: UITableView) {
        self.favoriteMovies = movies
        self.tableView = tableView
        self.tableView.rowHeight = CGFloat(FavoriteTableViewCell.cellHeight)
        self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
        super.init()
    }
    
    func addMovie(newMovie: Movie) {
        favoriteMovies.append(newMovie)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else {
            fatalError()
        }
        
        let movie = favoriteMovies[indexPath.row]
        cell.setup(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoritePersistenceService: MoviePersistenceProtocol = FavoritePersistenceService()
            let success = favoritePersistenceService.deleteMovie(movie: favoriteMovies[indexPath.row])
            if success {
                let deletedMovie = favoriteMovies[indexPath.row]
                NotificationCenter.default.post(name: .movieRemovedFromPersistence, object: self, userInfo: [PersistenceConstants.notificationUserInfoKey:deletedMovie])
                favoriteMovies.remove(at: indexPath.row)
            }
        }
    }
    
}
