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
    var genres: [Int:String] = [:]
    var movies: [Movie] = [] {
        didSet {
            setupDatasource()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        fetchMovies()
    }
    
    func setupDatasource() {
        datasource = MovieListDatasource(collectioView: collectionView, movies: movies)
        collectionView.dataSource = datasource
    }
    
    func setupDelegate() {
        delegate = MovieListDelegate()
        collectionView.delegate = delegate
    }
    
    func fetchMovies() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.collectionView.isHidden = true
        movieService.fetchMovies { movies in
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.movies = movies
        }
    }
    
    func fetchGenres() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.collectionView.isHidden = true
    }
    
}
