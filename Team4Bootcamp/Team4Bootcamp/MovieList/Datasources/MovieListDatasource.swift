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
        self.collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.movieListCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.movieListCell, for: indexPath) as? MovieCollectionViewCell else {
            fatalError()
        }
        
        let movie = self.filteredList()[indexPath.row]
        cell.setup(movie: movie, at: indexPath)
        cell.delegate = self
        return cell
    }
    
}

extension MovieListDatasource: MovieCollectionViewCellDelegate {
    
    func didFavoriteCell(_ isSelected: Bool, at position: IndexPath) {
        if let context = FavoritesViewController.container?.viewContext{
            DispatchQueue.main.async { // Correct
                if isSelected {
                    self.movies[position.row].persisted = MovieDAO.addMovie(movie: self.movies[position.row], context: context)
                    //favoritePersistenceService.addMovie(movie: movies[position.row])
                } else {
                    self.movies[position.row].persisted = !MovieDAO.deleteMovie(movie: self.movies[position.row], context: context)
                    //!favoritePersistenceService.deleteMovie(movie: movies[position.row])
                }
            }
        }
    }
}
