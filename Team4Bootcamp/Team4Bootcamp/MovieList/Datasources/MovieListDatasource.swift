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
    
    private let favoritePersistenceService = FavoritePersistenceService()
    
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
    
    func registerMovieWasFavoritedObserver(notificationName: Notification.Name) {
        NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: OperationQueue.main) { notification in
            if let info = notification.userInfo, let movie = info[PersistenceConstants.notificationUserInfoKey] as? Movie {
                if let index = self.getMovieIndex(movie: movie) {
                    self.movies[index].persisted = notificationName == .movieAddedToPersistence ? true : false
                }
            }
        }
    }
    
    
    init(movies: [Movie], collectionView: UICollectionView, searchBarDelegate: SearchBarDelegate?) {
        self.movies = movies
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
        registerMovieWasFavoritedObserver(notificationName: .movieAddedToPersistence)
        registerMovieWasFavoritedObserver(notificationName: .movieRemovedFromPersistence)
        self.collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.movieListCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getMovieCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.movieListCell, for: indexPath) as? MovieCollectionViewCell else {
            fatalError()
        }
        
        var movie = getMovies()[indexPath.row]

        if let context = FavoritesViewController.container?.viewContext {
            let predicate = NSPredicate(format: "id == \(movie.id)")
            let previouslyInserted = try? context.previouslyInserted(MovieDAO.self, predicateForDuplicityCheck: predicate)
            movie.persisted = previouslyInserted ?? false
        }
        cell.setup(movie: movie, at: indexPath)
        cell.delegate = self
        return cell
    }
}

extension MovieListDatasource: MovieCollectionViewCellDelegate {
    
    func didFavoriteCell(_ isSelected: Bool, at position: IndexPath) {
        if let context = FavoritesViewController.container?.viewContext {
            DispatchQueue.main.async {
                if isSelected {
                    let result = MovieDAO.addMovie(movie: self.movies[position.row], context: context)
                    switch result {
                    case .success:
                        self.movies[position.row].persisted = true
                    case .error:
                        self.movies[position.row].persisted = false
                    }
                } else {
                    let movie = self.movies[position.row]
                    let predicate = NSPredicate(format: "id == \(movie.id)")
                    let result = MovieDAO.deleteMovie(movie: self.movies[position.row], context: context, predicate: predicate)
                    switch result {
                    case .success:
                        self.movies[position.row].persisted = false
                    case .error:
                        self.movies[position.row].persisted = true
                    }
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
