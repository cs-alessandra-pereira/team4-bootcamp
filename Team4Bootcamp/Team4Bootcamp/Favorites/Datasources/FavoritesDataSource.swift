//
//  FavoritesDataSource.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

class FavoritesDataSource: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    static var fetchedResultsController: NSFetchedResultsController<MovieDAO>?
    
    let tableView: UITableView
    
    init(movies: [Movie], tableView: UITableView) {
        self.tableView = tableView
        self.tableView.rowHeight = CGFloat(FavoriteTableViewCell.cellHeight)
        self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
        if let context = FavoritesViewController.container?.viewContext {
            let request: NSFetchRequest<MovieDAO> = MovieDAO.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            FavoritesDataSource.fetchedResultsController = NSFetchedResultsController<MovieDAO>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            try? FavoritesDataSource.fetchedResultsController?.performFetch()
            tableView.reloadData()
        }
        super.init()
        FavoritesDataSource.fetchedResultsController?.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfMovies = FavoritesDataSource.fetchedResultsController?.fetchedObjects?.count {
            return numberOfMovies
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else {
            fatalError()
        }

        if let movieDAO = FavoritesDataSource.fetchedResultsController?.object(at: indexPath) {
            let movie = Movie(from: movieDAO)
            cell.setup(movie: movie)
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
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
