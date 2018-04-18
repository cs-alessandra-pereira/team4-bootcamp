//
//  FavoritesViewController.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let favoritePersistenceService: MoviePersistenceProtocol = FavoritePersistenceService()
    
    var favoritesDataSouce: FavoritesDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataSource(movies: [])
        fetchMovies()
        addMovie()
    }
    
    private func setupDataSource(movies: [MovieDAO]) {
        favoritesDataSouce = FavoritesDataSource(movies: movies, tableView: self.tableView)
        tableView.dataSource = favoritesDataSouce
    }
    
    private func fetchMovies() {
        favoritePersistenceService.fetchMovies { movies in
            self.favoritesDataSouce?.favoriteMovies = movies
        }
    }
    
    private func addMovie() {
        let movie = Movie(id: 269149, title: "Zootopia", releaseDate: Date(), genres: [Genre(id: 01, name: "Terror")], overview: "Normally, the label text is drawn with the font you specify in the font property. If this property is set to true, and the text in the text property exceeds the label’s bounding rectangle, the", posterPath: "/sM33SANp9z6rXW8Itn7NnG1GOEs.jpg", persisted: false)
        
        let result = favoritePersistenceService.addMovie(movie: movie)
        
        if let newMovie = result {
            favoritesDataSouce?.addMovie(newMovie: newMovie)
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate {

}
