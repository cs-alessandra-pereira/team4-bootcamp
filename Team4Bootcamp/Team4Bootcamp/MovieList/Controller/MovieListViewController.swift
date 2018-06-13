//
//  MovieListViewController.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 28/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

class MovieListViewController: UIViewController {
    
    weak static var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.coredata.persistentContainer
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewNoResults: UIView!
    @IBOutlet weak var viewError: UIView!
    
    var movieListDatasource: MovieListDatasource?
    var collectionViewDelegate: CollectionViewDelegate?
    var searchBarDelegate: SearchBarDelegate?
    
    var movieService: MoviesProtocol = MoviesAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupSearchBar()
        fetchGenres()
        fetchMovies()
        adjustNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func setupDelegates() {
        collectionViewDelegate = CollectionViewDelegate()
        collectionView.delegate = collectionViewDelegate

        collectionViewDelegate?.callback = { [weak self] collectionEvent, movieIndex in
            switch collectionEvent {
            case .didSelectItemAt:
                self?.proceedToDetailsView(movieIndex: movieIndex)
            case .willDisplayMoreCells:
                let count = self?.movieListDatasource?.getMovieCount()
                if movieIndex == count! - 1 {
                    if MoviesConstants.pageBaseURL <= MoviesConstants.paginationLimit {
                        self?.fetchMovies()
                    }
                }
            }
        }
    }
    
    func setupSearchBar() {
        searchBarDelegate = SearchBarDelegate()
        searchBar.delegate = searchBarDelegate
    }
    
    func fetchGenres() {
        self.state = .loading
        movieService.fetchGenres { result in
            switch result {
            case .success(let genres):
                GenreDAO.allGenres = genres
                self.state = .initial
            case .error:
                self.state = .error
            }
        }
    }
    
    func fetchMovies() {
        if let searching = searchBar.text?.count, searching > 0 { return }
        movieService.fetchMovies { result in
            switch result {
            case .success(let movies):
                if let datasource = self.movieListDatasource {
                    datasource.addMovies(newMovies: movies)
                    self.state = .initial
                } else {
                    if movies.count > 0 {
                        self.setupDatasource(movies: movies, searchBarDelegate: self.searchBar.delegate as? SearchBarDelegate)
                        self.state = .initial
                    } else {
                            self.state = .noResults
                    }
                }
            case .error(let error):
                if case MoviesError.noData = error {
                    self.state = .noResults
                } else {
                    self.state = .error
                }
            }
        }
    }
    
    func setupDatasource(movies: [Movie], searchBarDelegate: SearchBarDelegate?) {
        movieListDatasource = MovieListDatasource(movies: movies, collectionView: collectionView, searchBarDelegate: searchBarDelegate)
        collectionView.dataSource = movieListDatasource
    }
    
    func adjustNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private enum ScreenState {
        case initial
        case error
        case loading
        case noResults
    }
    
    private var state: ScreenState = .initial {
        didSet {
            switch state {
            case .initial:
                activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                viewNoResults.isHidden = true
                viewError.isHidden = true
                collectionView.isHidden = false
                searchBar.isHidden = false
    
            case .loading:
                collectionView.isHidden = true
                searchBar.isHidden = true
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            case .error:
                searchBar.isHidden = true
                activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                collectionView.isHidden = true
                viewNoResults.isHidden = true
                viewError.isHidden = false
            case .noResults:
                activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                searchBar.isHidden = false
                viewError.isHidden = true
                viewNoResults.isHidden = false
                collectionView.isHidden = true
            }
        }
    }
    
    func proceedToDetailsView(movieIndex: Int) {
        if let movie = movieListDatasource?.getMovies()[movieIndex] {
            let controller = MovieDetailsViewController(movie: movie)
            controller.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
