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
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = movieDetailsView
        setupDatasource()
        setMovieImage()
    }
    
    override func viewDidLoad() {
        movieDetailsView.persistedButton.isSelected = movie.persisted
    }
    func setupDatasource() {
        
        datasource = MovieDetailsDatasource(tableView: movieDetailsView.tableView, movie: movie)
        movieDetailsView.tableView.dataSource = datasource
    }
    
    func setMovieImage() {
        
        let path = Endpoints.moviePoster(movie.posterPath).path
        imageFetchable.fetch(imageURLString: path, onImage: movieDetailsView.posterIamge) {}
        
    }
    
}
