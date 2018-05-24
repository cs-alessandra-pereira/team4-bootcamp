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
    weak var rightBarButton: UIBarButtonItem?
    
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
        updateDatabase()
    }
    
    func setupFilterButton() {
        let icon = UIImage(icon: .filter)
        let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(filterAction) )
        self.navigationItem.rightBarButtonItem = button
        rightBarButton = button
    }
    
    @objc
    func filterAction() {
        let filterViewController = FilterViewController()
        filterViewController.hidesBottomBarWhenPushed = true
        
        if let movies = favoritesDataSouce?.movies {
            filterViewController.setupMovies(movies)
        }
        
        filterViewController.selectedYears = favoritesDataSouce?.yearToFilter ?? []
        filterViewController.selectedGenreNames = favoritesDataSouce?.genresToFilter ?? []
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? self.fetchedResultsController?.performFetch()
        self.tableView.reloadData()
        refreshScreenState()
    }
    
    func setupDataSource() {
        favoritesDataSouce = FavoritesDataSource(tableView: self.tableView, fetchedResults: fetchedResultsController!, searchBarDelegate: searchBarDelegate)
        tableView.dataSource = favoritesDataSouce
        
        favoritesDataSouce?.deletedMovieCallback = { [weak self] movie in
            if let context = FavoritesViewController.container?.viewContext {
                let restult = MovieDAO.deleteMovie(context: context, predicate: NSPredicate(format: "id == \(movie.id)"))
                switch restult {
                case .success:
                        try? self?.fetchedResultsController?.performFetch()
                        self?.tableView.reloadData()
                        self?.refreshScreenState()
                        NotificationCenter.default.post(name: .movieRemovedFromPersistence, object: self, userInfo: [PersistenceConstants.notificationUserInfoKey: movie])
                case .error:
                    break
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
    
    func updateDatabase() {
        if let context = MovieListViewController.container?.viewContext {
            let request: NSFetchRequest<GenreDAO> = GenreDAO.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            let fetchedResultsController = NSFetchedResultsController<GenreDAO>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            try? fetchedResultsController.performFetch()
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
        favoritesDataSouce?.filteredMovies = nil
        refreshScreenState()
    }
    
    private enum ScreenState {
        case noFavorites
        case filterOff
        case filterOn
    }
    
    func refreshScreenState() {
        guard let datasource = favoritesDataSouce, !datasource.movies.isEmpty else {
            self.screenState = .noFavorites
            return
        }
        if !datasource.yearToFilter.isEmpty || !datasource.genresToFilter.isEmpty {
            screenState = .filterOn
        } else {
            screenState = .filterOff
        }
    }
    
    private var screenState: ScreenState = .noFavorites {
        didSet {
            switch screenState {
            case .noFavorites:
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
                removeFilterButton.isHidden = true
                searchBar.isHidden = true
            case .filterOff:
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = nil
                removeFilterButton.isHidden = true
                searchBar.isHidden = true
                searchBar.isHidden = false
            case .filterOn:
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = nil
                removeFilterButton.isHidden = false
                searchBar.isHidden = false
            }
        }
    }
}
