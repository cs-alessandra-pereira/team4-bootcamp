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
    
    var datasource: UICollectionViewDataSource?
    var collectionViewDelegate: UICollectionViewDelegate?
    var searchBarDelegate: UISearchBarDelegate?
    
    var movieService: MoviesServiceProtocol = MoviesAPI()
    
    var movies: [Movie] = [] {
        didSet {
            setupDatasource()
        }
    }
    
    var filterBy: String? = nil {
        didSet {
            setupDatasource()
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
        datasource = MovieListDatasource(collectioView: collectionView, movies: movies)
        collectionView.dataSource = datasource
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
    
    // TODO: preciso chamar esta funcão para atualizar o datasource com os filmes filtrados
    // como fazer isso sem o datasource ter conhecimento dos detalhes do vc específico?
    func filteredMovies() -> [Movie] {
        guard let filterBy = self.filterBy else {
            return movies
        }
        return movies.filter { $0.title.lowercased().starts(with: filterBy.lowercased()) }
    }
    
    private enum UIState {
        case initial
        case error
        case loading
    }
    
    private var state: UIState = .initial {
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
