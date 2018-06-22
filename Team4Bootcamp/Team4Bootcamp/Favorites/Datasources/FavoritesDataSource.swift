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
    
    weak static var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.coredata.persistentContainer
    
    init(tableView: UITableView, searchBarDelegate: SearchBarDelegate?) {
        self.tableView = tableView
        self.tableView.rowHeight = CGFloat(FavoriteTableViewCell.cellHeight)
        self.tableView.register(FavoriteTableViewCell.self)
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
        setupFetchedResultController()
    }
    
    var yearToFilter: [String] = []
    var genresToFilter: [String] = []
    
    var searchString: String? = nil {
        didSet {
            performNewFetch()
        }
    }
    
    func setupFetchedResultController(withPredicate predicate: NSPredicate? = nil) {
        let sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let request = container!.viewContext.buildNSFetchRequest(forClass: MovieDAO.self, sortBy: sortDescriptors, predicate: predicate)
        let fetchedRC = container?.viewContext.buildNSFetchedResultsController(withRequest: request)
        self.fetchedResultsController = fetchedRC
        self.fetchedResultsController?.delegate = self
    }
    
    func refreshFetchedResultsController() {
        try? self.fetchedResultsController?.performFetch()
    }
    
    func performNewFetch() {
        var predicates: [NSPredicate] = []
        if yearToFilter.count > 0 {
            predicates.append(MovieDAOPredicates.yearFiltering(yearToFilter).predicate)
        }
        if genresToFilter.count > 0 {
            predicates.append(MovieDAOPredicates.genreFiltering(genresToFilter).predicate)
        }
        if let search = searchString, !search.isEmpty {
            predicates.append(MovieDAOPredicates.titleSearch(search).predicate)
        }
        let compoundPredicates = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        setupFetchedResultController(withPredicate: compoundPredicates)
        refreshFetchedResultsController()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoriteTableViewCell = tableView.dequeueReusableCell(for: indexPath)

        if getMovieCount() > 0 {
            let movieDAO = getMovies()[indexPath.row]
            let movie = Movie(from: movieDAO)
            cell.setup(movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        return movies.count
    }
    
    func getMovies() -> [MovieDAO] {
        return movies
    }
}
