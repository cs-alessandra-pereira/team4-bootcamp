//
//  FavoritesViewController.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let favoritePersistenceService: MoviePersistenceProtocol = FavoritePersistenceService()
    
    var favoritesDataSouce: FavoritesDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource(movies: [])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    private func setupDataSource(movies: [Movie]) {
        favoritesDataSouce = FavoritesDataSource(movies: movies, tableView: self.tableView)
        tableView.dataSource = favoritesDataSouce
    }
    
    private func fetchMovies() {
        favoritePersistenceService.fetchMovies { result in
            switch result {
            case .success(let movies):
                self.favoritesDataSouce?.favoriteMovies = movies
            case .error:
                break
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {

}
