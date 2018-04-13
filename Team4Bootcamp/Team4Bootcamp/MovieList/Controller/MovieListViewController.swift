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
    
    var movieListDatasource: MovieListDatasource?
    var collectionViewDelegate: CollectionViewDelegate?
    var movieService: MoviesServiceProtocol = MoviesAPI()
    
//    var filterBy: String? = nil {
//        didSet {
//            movieListDatasource?.movies = filteredMovies()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupSearchBar()
        fetchGenres()
        fetchMovies()
    }
    
    func setupDatasource(movies: [Movie], searchBarDelegate: SearchBarDelegate) {
        movieListDatasource = MovieListDatasource(collectionView: collectionView, searchBarDelegate: searchBarDelegate)
        collectionView.dataSource = movieListDatasource
    }
    
    func setupDelegate() {
        
        collectionViewDelegate = CollectionViewDelegate(datasource: self.movieListDatasource) { movie in
            self.proceedToDetailsView(movie: movie)
        }
        
        collectionView.delegate = collectionViewDelegate
    }
    
    func setupSearchBar() {
        searchBar.delegate = SearchBarDelegate()
    }
    
    func fetchMovies() {
        movieService.fetchMovies { movies in
            self.setupDatasource(movies: movies, searchBarDelegate: self.searchBar.delegate as! SearchBarDelegate) //swiftlint:disable:this force_cast
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
    
//    func filteredMovies() -> [Movie] {
//        guard let filterBy = self.filterBy else {
//            return movies
//        }
//        return movies.filter { $0.title.lowercased().starts(with: filterBy.lowercased()) }
//    }
    
    private enum ScreenState {
        case initial
        case error
        case loading
    }
    
    private var state: ScreenState = .initial {
        didSet {
            switch state {
            case .initial:
                activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
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
                collectionView.isHidden = false
            }
        }
    }
    
    func proceedToDetailsView(movie: Movie) {
        let controller = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}
