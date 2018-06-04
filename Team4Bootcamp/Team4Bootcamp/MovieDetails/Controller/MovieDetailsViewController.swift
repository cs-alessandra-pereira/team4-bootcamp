//
//  MovieDetailsViewController.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 05/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var datasource: UITableViewDataSource?
    let imageFetchable: ImageFetchable = KFImageFetchable()
    
    var movieDetailsView = MovieDetailsView()
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = movieDetailsView
        movieDetailsView.persistedButtonDelegate = self
        setupDatasource()
        setMovieImage()
    }
    
    override func viewDidLoad() {
        isMovieFavorited()
    }
    func setupDatasource() {
        
        datasource = MovieDetailsDatasource(tableView: movieDetailsView.tableView, movie: movie)
        movieDetailsView.tableView.dataSource = datasource
    }
    
    func setMovieImage() {
        
        let path = Endpoints.moviePoster(movie.posterPath).path
        imageFetchable.fetch(imageURLString: path, onImage: movieDetailsView.posterImage) {}
        
    }
    
    func isMovieFavorited() {
        if let context = FavoritesViewController.container?.viewContext {
            let predicate = NSPredicate(format: "id == \(movie.id)")
            let previouslyInserted = try? context.previouslyInserted(MovieDAO.self, predicateForDuplicityCheck: predicate)
            movie.persisted = previouslyInserted ?? false
        }
        movieDetailsView.persistedButton.isSelected = movie.persisted
    }
}

extension MovieDetailsViewController: MovieDetailFavoriteDelegate {
    func didFavoriteMovie(_ isSelected: Bool) {
        if let context = FavoritesViewController.container?.viewContext {
            DispatchQueue.main.async {
                if isSelected {
                    _ = MovieDAO.addMovie(movie: self.movie, context: context)
                    
                } else {
                    let predicate = NSPredicate(format: "id == \(self.movie.id)")
                    _ = MovieDAO.deleteMovie(context: context, predicate: predicate)
                }
            }
        }
    }
}
