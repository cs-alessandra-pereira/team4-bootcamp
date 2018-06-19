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
    
    weak static var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.coredata.persistentContainer
    
    var favoritesDataSource: FavoritesDataSource?
    var favoriteTableViewDelegate: FavoriteTableViewDelegate?
    var searchBarDelegate: SearchBarDelegate?
    var tabBarDelegate: TabBarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        //setupNSFetched()
        setupSearchBar()
        adjustNavigationBar()
        setupDataSource()
        setupDelegate()
        setupFilterButton()
        setupDelegateTabBar()
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
        
        if let movies = favoritesDataSource?.movies {
            filterViewController.setupMovies(movies)
        }
        if let ctx = FavoritesViewController.container?.viewContext {
            filterViewController.setupGenres(context: ctx)
        }
        
        filterViewController.selectedYears = favoritesDataSource?.yearToFilter ?? []
        filterViewController.selectedGenreNames = favoritesDataSource?.genresToFilter ?? []
        self.navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesDataSource?.refreshFetchedResultsController()
        self.tableView?.reloadData()
        refreshScreenState()
    }
    
    func setupDataSource() {
        favoritesDataSource = FavoritesDataSource(tableView: self.tableView, searchBarDelegate: searchBarDelegate)
        tableView.dataSource = favoritesDataSource
        
        favoritesDataSource?.deletedMovieCallback = { [weak self] movie in
            if let context = FavoritesViewController.container?.viewContext {
                let restult = MovieDAO.deleteMovie(context: context, predicate: NSPredicate(format: "id == \(movie.id)"))
                switch restult {
                case .success:
                    
                    do {
                        try self?.favoritesDataSource?.fetchedResultsController?.performFetch()
                        self?.tableView.reloadData()
                        self?.refreshScreenState()
                    } catch { fatalError("Could not perform fetch") }
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
    }
    
    func setupDelegateTabBar() {
        tabBarDelegate = TabBarDelegate()
        tabBarController?.delegate = tabBarDelegate
        
        tabBarDelegate?.callbackFromSelectedTabBarItem = { [weak self] event in
            switch event {
            case .firstItemSelected:
                self?.removeFilter(true)
            default:
                break
            }
        }
    }
    
    func adjustNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func proceedToDetailsView(movieIndex: IndexPath) {
        if let favorites = favoritesDataSource {
            let movieDAO = favorites.searchedList()[movieIndex.row]
            let movie = Movie(from: movieDAO)
            let controller = MovieDetailsViewController(movie: movie)
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func removeFilter(_ sender: Any) {
        favoritesDataSource?.yearToFilter = []
        favoritesDataSource?.genresToFilter = []
        favoritesDataSource?.filteredMovies = nil
        refreshScreenState()
    }
    
    private enum ScreenState {
        case noFavorites
        case filterOff
        case filterOn
    }
    
    func refreshScreenState() {
        guard let datasource = favoritesDataSource, !datasource.movies.isEmpty else {
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
                removeFilterButton?.isHidden = true
                searchBar?.isHidden = true
            case .filterOff:
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = nil
                removeFilterButton?.isHidden = true
                searchBar?.isHidden = true
                searchBar?.isHidden = false
            case .filterOn:
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = nil
                removeFilterButton?.isHidden = false
                searchBar?.isHidden = false
            }
        }
    }
}
