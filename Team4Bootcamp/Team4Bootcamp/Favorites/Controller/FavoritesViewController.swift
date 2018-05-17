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
    @IBOutlet weak var removeFilterButton: UIButton!
    
    private let favoritePersistenceService = FavoritePersistenceService()
    fileprivate var fetchedResultsController: NSFetchedResultsController<MovieDAO>?
    
    static var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.coredata.persistentContainer
    
    var favoritesDataSouce: FavoritesDataSource?
    var favoriteTableViewDelegate: FavoriteTableViewDelegate?
    var searchBarDelegate: SearchBarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNSFetched()
        setupSearchBar()
        adjustNavigationBar()
        setupDataSource()
        setupDelegate()
        setupFilterButton()
    }
    
    func setupFilterButton() {
        let icon = UIImage(icon: .filter)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(filterAction) )
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc
    func filterAction() {
        let filterViewController = FilterViewController()
        filterViewController.hidesBottomBarWhenPushed = true
        filterViewController.setupMovies(favoritesDataSouce?.movies)
        filterViewController.selectedYears = favoritesDataSouce?.yearToFilter ?? []
        filterViewController.selectedGenreNames = favoritesDataSouce?.genresToFilter ?? []
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var enableRemoveFilterButton = false
        if favoritesDataSouce?.yearToFilter != [] || favoritesDataSouce?.genresToFilter != [] {
            enableRemoveFilterButton = true
        }
        self.state = enableRemoveFilterButton == false ? .noFilter : .filtered
    
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
        favoriteTableViewDelegate = FavoriteTableViewDelegate()
        tableView.delegate = favoriteTableViewDelegate
        favoriteTableViewDelegate?.callbackFromSelectedRow = { [weak self] movieIndex in
            self?.proceedToDetailsView(movieIndex: movieIndex)
        }

    }
    
    func setupSearchBar() {
        searchBarDelegate = SearchBarDelegate()
        searchBar.delegate = searchBarDelegate
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.primaryColor?.cgColor
        if let textField = searchBar.value(forKey: "_searchField") as? UITextField {
            textField.backgroundColor = UIColor.accentColor
        }
    }
    
    func adjustNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
        if let moviesDAO = favoritesDataSouce?.movies {
            if let movieDAO = favoritesDataSouce?.searchedList(movies: moviesDAO)[movieIndex.row] {
                let movie = Movie(from: movieDAO)
                let controller = MovieDetailsViewController(movie: movie)
                controller.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    @IBAction func removeFilter(_ sender: Any) {
    
        favoritesDataSouce?.yearToFilter = []
        favoritesDataSouce?.genresToFilter = []
        self.state = .noFilter
        
    }
    
    private enum ScreenState {
        case noFilter
        case filtered
    }
    
    private var state: ScreenState = .noFilter {
        didSet {
            switch state {
            case .noFilter:
                removeFilterButton.isHidden = true
                
            case .filtered:
                removeFilterButton.isHidden = false
            }
        }
    }
}
