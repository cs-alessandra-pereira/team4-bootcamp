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
        didSet{
            filteredMovieList = movies
        }
    }
    
    var filteredMovieList: [Movie] = []
    
    weak private var collectionView: UICollectionView?
    
    private var searchString: String? = nil {
        didSet{
            if let searchString = searchString {
                filteredMovieList = searchString.isEmpty ? movies : movies.filter { movie in
                    return movie.title.lowercased().starts(with: searchString.lowercased())
                }
            } else{
                filteredMovieList = movies
            }
            collectionView?.reloadData()
        }
    }
    
    init(movies: [Movie], collectionView: UICollectionView, searchBarDelegate: SearchBarDelegate?) {
        self.movies = movies
        self.filteredMovieList = movies
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
        return filteredMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.movieListCell, for: indexPath) as? MovieCollectionViewCell else {
            fatalError()
        }
        
        let movie = self.filteredMovieList[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
    
}
