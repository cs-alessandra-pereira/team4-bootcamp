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
    fileprivate var fetchedResultsController: NSFetchedResultsController<MovieDAO>?
    
    static var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    var favoritesDataSouce: FavoritesDataSource?
    var favoriteTableViewDelegate: FavoriteTableViewDelegate?
    var searchBarDelegate: SearchBarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNSFetched()
        setupSearchBar()
        setupDataSource()
        setupDelegate()
    }
    
    func setupDataSource() {
        favoritesDataSouce = FavoritesDataSource(tableView: self.tableView, fetchedResults: fetchedResultsController!, searchBarDelegate: searchBarDelegate)
        tableView.dataSource = favoritesDataSouce
        
        favoritesDataSouce?.deletedMovieCallback = { [weak self] movie in
            if let context = FavoritesViewController.container?.viewContext {
                let success = MovieDAO.deleteMovie(movie: movie, context: context)
                if success {
                    NotificationCenter.default.post(name: .movieRemovedFromPersistence, object: self, userInfo: [PersistenceConstants.notificationUserInfoKey: movie])
                }
            }
        }
    }
    
    func setupDelegate() {
        favoriteTableViewDelegate = FavoriteTableViewDelegate { [weak self] movieIndex in
            self?.proceedToDetailsView(movieIndex: movieIndex)
        }
        tableView.delegate = favoriteTableViewDelegate
    }
    
    func setupSearchBar() {
        searchBarDelegate = SearchBarDelegate()
        searchBar.delegate = searchBarDelegate
    }
    
    func setupNSFetched() {
        if let context = FavoritesViewController.container?.viewContext {
            let request: NSFetchRequest<MovieDAO> = MovieDAO.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            fetchedResultsController = NSFetchedResultsController<MovieDAO>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            try? fetchedResultsController?.performFetch()
            tableView.reloadData()
        }
    }
    
    func proceedToDetailsView(movieIndex: IndexPath) {
        if let movieDAO = favoritesDataSouce?.filteredList()[movieIndex.row] {
            let movie = Movie(from: movieDAO)
            let controller = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
