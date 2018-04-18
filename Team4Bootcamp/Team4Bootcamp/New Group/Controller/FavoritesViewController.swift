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
        let movie = Movie(id: 01, title: "Teste", releaseDate: Date(), genres: [Genre(id: 01, name: "Terror")], overview: "Normally, the label text is drawn with the font you specify in the font property. If this property is set to true, and the text in the text property exceeds the label’s bounding rectangle, the", posterPath: "/eKi8dIrr8voobbaGzDpe8w0PVbC.jpg")
        
        setupDataSource(movies: [movie])
    }
    func setupDataSource(movies: [Movie]) {
        favoritesDataSouce = FavoritesDataSource(movies: movies, tableView: self.tableView)
        tableView.dataSource = favoritesDataSouce
    }
    
    func fetchMovies() {
        favoritePersistenceService.fetchMovies { movies in
            self.favoritesDataSouce?.favoriteMovies = movies
        }
    }
//    let friend = Friend(entity: Friend.entity(), insertInto: context)
//    friend.name = data.name
//    appDelegate.saveContext()
//    friends.append(friend)
//    let index = IndexPath(row:friends.count - 1, section:0)
//    collectionView?.insertItems(at: [index])
    
    
}

extension FavoritesViewController: UITableViewDelegate {

}
