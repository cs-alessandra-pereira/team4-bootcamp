//
//  MovieListViewController.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 28/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let insets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = insets
            layout.itemSize = CGSize(width: 180, height: 220)
            collectionView.collectionViewLayout = layout
            collectionView.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewNoResults: UIView!
    @IBOutlet weak var viewError: UIView!
    
    var movieListDatasource: MovieListDatasource?
    var collectionViewDelegate: CollectionViewDelegate?
    var searchBarDelegate: SearchBarDelegate?
    
    var movieService: MoviesServiceProtocol = MoviesAPI()
    
    var movies: [Movie] = [] {
        didSet {
            setupDatasource()
        }
    }
    
    var filterBy: String? = nil {
        didSet {
            movieListDatasource?.movies = filteredMovies()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupSearchBar()
        fetchGenres()
        fetchMovies()
    }
    
    func setupDatasource() {
        movieListDatasource = MovieListDatasource(collectionView: collectionView, movies: movies)
        collectionView.dataSource = movieListDatasource
    }
    
    func setupDelegate() {
        collectionViewDelegate = CollectionViewDelegate(viewController: self)
        collectionView.delegate = collectionViewDelegate
    }
    
    func setupSearchBar() {
        searchBarDelegate = SearchBarDelegate { searchBar, searchBarEvent, searchText in
            switch searchBarEvent {
            case .cancelled:
                self.filterBy = nil
                searchBar.resignFirstResponder()
            case .posted:
                searchBar.resignFirstResponder()
            case .textChanged:
                self.filterBy = searchText ?? nil
            }
        }
        self.searchBar.delegate = searchBarDelegate
    }
    
    func fetchMovies() {
        movieService.fetchMovies { movies in
            self.movies = movies
            self.state = .initial
        }
    }
    
    func fetchGenres() {
        self.state = .loading
        movieService.fetchGenres {
            Genre.allGenres = $0
            self.state = .initial
        }
    }
    
    func filteredMovies() -> [Movie] {
        guard let filterBy = self.filterBy else {
            return movies
        }
        return movies.filter { $0.title.lowercased().starts(with: filterBy.lowercased()) }
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
                collectionView.isHidden = false
                searchBar.isHidden = false
                viewError.isHidden = true
                viewNoResults.isHidden = true
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
                collectionView.isHidden = true
                searchBar.isHidden = false
                viewError.isHidden = true
                viewNoResults.isHidden = false
            }
        }
    }
    
    func proceedToDetailsView(movie: Movie) {
        let controller = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}
