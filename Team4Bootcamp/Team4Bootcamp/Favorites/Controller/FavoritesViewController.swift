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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNSFetched()
        setupDataSource(movies: [])
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetchMovies()
    }
    private func setupDataSource(movies: [Movie]) {
        favoritesDataSouce = FavoritesDataSource(movies: movies, tableView: self.tableView, fetchedResults: fetchedResultsController!)
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
        if let movieDAO = fetchedResultsController?.object(at: movieIndex) {
            let movie = Movie(from: movieDAO)
            let controller = MovieDetailsViewController(movie: movie)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
