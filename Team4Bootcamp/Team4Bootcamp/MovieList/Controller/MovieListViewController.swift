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
    var datasource: MovieListDatasource?
    var movieService: MoviesServiceProtocol = MoviesAPI()
    var movies: [Movie] = [] {
        didSet {
            setupDatasource()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    func setupDatasource() {
        collectionView.delegate = self
        datasource = MovieListDatasource(collectioView: collectionView, movies: movies)
        collectionView.dataSource = datasource
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
    
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}
