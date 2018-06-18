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
    var delegate: MovieListViewHandler?
    var collectionViewDelegate: CollectionViewDelegate?
    var searchBarDelegate: SearchBarDelegate?
    
    var movieService: MoviesProtocol = MoviesAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupDatasource()
        setupCallbacks()
        fetchGenres()
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func setupDelegates() {
        self.delegate = MovieListStatesController(viewController: self)

        collectionViewDelegate = CollectionViewDelegate()
        collectionView.delegate = collectionViewDelegate
        
        searchBarDelegate = SearchBarDelegate()
        searchBar.delegate = searchBarDelegate
    }
    
    func setupDatasource() {
        movieListDatasource = MovieListDatasource(collectionView: collectionView, searchBarDelegate: searchBarDelegate)
        collectionView.dataSource = movieListDatasource
    }
    
    func setupCallbacks() {
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
    
    func fetchGenres() {
        movieService.fetchGenres { result in
            switch result {
            case .success(let genres):
                GenreDAO.allGenres = genres
            case .error:
                self.delegate?.state = .error
            }
        }
    }
    
    func fetchMovies() {
        if let searching = searchBar.text?.count, searching > 0 { return }
        movieService.fetchMovies { result in
            switch result {
            case .success(let movies):
                if movies.count > 0 {
                    self.movieListDatasource?.addMovies(newMovies: movies)
                }
                self.delegate?.state = .success
            case .error(let error):
                if case MoviesError.noData = error {
                    self.delegate?.state = .noData
                } else {
                    self.delegate?.state = .error
                }
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
