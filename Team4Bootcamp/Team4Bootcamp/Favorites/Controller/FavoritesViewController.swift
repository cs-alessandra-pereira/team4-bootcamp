//
//  FavoritesViewController.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let favoritePersistenceService = FavoritePersistenceService()
    
    static var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    var favoritesDataSouce: FavoritesDataSource?
    var favoriteTableViewDelegate: FavoriteTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource(movies: [])
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetchMovies()
    }
    private func setupDataSource(movies: [Movie]) {
        favoritesDataSouce = FavoritesDataSource(movies: movies, tableView: self.tableView)
        tableView.dataSource = favoritesDataSouce
    }
    func setupDelegate() {
        favoriteTableViewDelegate = FavoriteTableViewDelegate()
        tableView.delegate = favoriteTableViewDelegate
        
        favoriteTableViewDelegate?.callback = { [weak self] tableViewEvent, movieIndex in
            switch tableViewEvent {
            case .didSelectItemAt:
                self?.proceedToDetailsView(movieIndex: movieIndex)
            }
        }
    }
    
    func proceedToDetailsView(movieIndex: IndexPath) {
        if let movieDAO = FavoritesDataSource.fetchedResultsController?.object(at: movieIndex) {
            let movie = Movie(from: movieDAO)
            let controller = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
