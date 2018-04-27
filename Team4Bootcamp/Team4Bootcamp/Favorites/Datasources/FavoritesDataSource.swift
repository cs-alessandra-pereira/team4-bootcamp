//
//  FavoritesDataSource.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

typealias DeletedMovieCallback = ((Movie) -> Void)?

class FavoritesDataSource: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var fetchedResultsController: NSFetchedResultsController<MovieDAO>?
    let container = FavoritesViewController.container
    var deletedMovieCallback: DeletedMovieCallback = nil
    var tableView: UITableView
    
    init(tableView: UITableView, fetchedResults: NSFetchedResultsController<MovieDAO>, searchBarDelegate: SearchBarDelegate?) {
        self.fetchedResultsController = fetchedResults
        self.tableView = tableView
        self.tableView.rowHeight = CGFloat(FavoriteTableViewCell.cellHeight)
        self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
        super.init()
        searchBarDelegate?.callback = { [weak self] searchBar, searchEvent, searchString in
            switch searchEvent {
            case .cancelled:
                self?.searchString = nil
                searchBar.resignFirstResponder()
            case .posted:
                searchBar.resignFirstResponder()
            case .textChanged:
                self?.searchString = searchString
            }
        }
        self.fetchedResultsController?.delegate = self
    }
    
    private var searchString: String? = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    func filteredList() -> [MovieDAO] {
        guard let searchString = self.searchString else {
            return self.movies
        }
        return self.movies.filter { $0.title.lowercased().starts(with: searchString.lowercased()) }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMovieCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else {
            fatalError()
        }
        
        let movieDAO = getMovies()[indexPath.row]
        let movie = Movie(from: movieDAO)
        cell.setup(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let searching = searchString {
            if searching.count > 0 {
                return
            }
        }
        if editingStyle == .delete {
            let movieDAO = getMovies()[indexPath.row]
            let movie = Movie(from: movieDAO)
            deletedMovieCallback?(movie)
        }
    }
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

extension FavoritesDataSource: MovieListManager {
    var movies: [MovieDAO] {
        get {
            return fetchedResultsController?.fetchedObjects ?? []
        }
        set {
            
        }
    }
    
    typealias Item = MovieDAO
    
    func getMovieCount() -> Int {
        return filteredList().count
    }
    
    func getMovies() -> [MovieDAO] {
        return filteredList()
    }
}
