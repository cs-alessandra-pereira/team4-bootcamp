//
//  MovieListDatasource.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 03/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

final class MovieListDatasource: NSObject, UICollectionViewDataSource {
    
    var movies: [Movie] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    weak var collectionView: UICollectionView?
    
    private var movieWasFavoritedObservers: [NSObjectProtocol] = []
    
    private var searchString: String? = nil {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    func filteredList() -> [Movie] {
        guard let searchString = self.searchString else {
            return self.movies
        }
        return self.movies.filter { $0.title.lowercased().starts(with: searchString.lowercased()) }
    }
    
    func registerMovieWasFavoritedObserver(notificationName: Notification.Name) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: OperationQueue.main) { notification in
            if let info = notification.userInfo, let movie = info[PersistenceConstants.notificationUserInfoKey] as? Movie {
                if let index = self.getMovieIndex(movie: movie) {
                    self.movies[index].persisted = notificationName == .movieAddedToPersistence ? true : false
                }
            }
        }
    }
    
    
    init(collectionView: UICollectionView, searchBarDelegate: SearchBarDelegate?) {
        self.collectionView = collectionView
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
        
        movieWasFavoritedObservers.append(registerMovieWasFavoritedObserver(notificationName: .movieAddedToPersistence))
        movieWasFavoritedObservers.append(registerMovieWasFavoritedObserver(notificationName: .movieRemovedFromPersistence))
        
        self.collectionView?.register(MovieCollectionViewCell.self)
    }
    
    deinit {
        for obeserver in movieWasFavoritedObservers {
            NotificationCenter.default.removeObserver(obeserver)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMovieCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: MovieCollectionViewCell = self.collectionView?.dequeueReusableCell(for: indexPath) else {
            fatalError()
        }
        
        var movie = getMovies()[indexPath.row]

        if let context = MovieListViewController.container?.viewContext {
            let previouslyInserted = try? MovieDAO.wasPreviouslyInserted(movie: movie, context: context)
            movie.persisted = previouslyInserted ?? false
        }
        cell.setup(movie: movie, at: indexPath)
        cell.delegate = self
        return cell
    }
}

extension MovieListDatasource: MovieCollectionViewCellDelegate {
    
    func didFavoriteCell(_ isSelected: Bool, at position: IndexPath) {
        if let context = MovieListViewController.container?.viewContext {
            DispatchQueue.main.async {
                if isSelected {
                    MovieDAO.addMovie(movie: self.getMovies()[position.row], context: context)

                } else {
                    MovieDAO.deleteMovie(context: context, movie: self.getMovies()[position.row])
                }
            }
        }
    }
}

extension MovieListDatasource: MovieListManager {
    
    typealias Item = Movie
    
    func getMovieCount() -> Int {
        return filteredList().count
    }
    
    func getMovies() -> [Movie] {
        return filteredList()
    }
}
