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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var datasource: UICollectionViewDataSource?
    var delegate: UICollectionViewDelegate?
    
    var movieService: MoviesServiceProtocol = MoviesAPI()
    var movies: [Movie] = [] {
        didSet {
            setupDatasource()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        fetchGenres()
        fetchMovies()
    }
    
    func setupDatasource() {
        datasource = MovieListDatasource(collectioView: collectionView, movies: movies)
        collectionView.dataSource = datasource
    }
    
    func setupDelegate() {
        delegate = MovieListDelegate(viewController: self)
        collectionView.delegate = delegate
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
            case .loading:
                collectionView.isHidden = true
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            case .error:
                activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                collectionView.isHidden = false
                //Tratar tela para erro
            }
        }
    }
    
    func fillMoviesWithGenreNames(genreList: [GenreId: GenreName], movieList: [Movie]) -> [Movie] {
        //Usar inout ou atribuir a uma nova var?
        var filledMovieList: [Movie] = []
        for var movie in movieList {
            var genres: [Genre] = []
            for var genre in movie.genres {
                if let name = genreList[genre.id] {
                    genre.name = name
                    genres.append(genre)
                }
            }
            movie.genres = genres
            filledMovieList.append(movie)
        }
        
        return filledMovieList
    }
    
    func proceedToDetailsView(movie: Movie) {
        let controller = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}
