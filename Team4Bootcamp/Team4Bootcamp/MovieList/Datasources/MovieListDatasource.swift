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
            self.collectionView?.reloadData()
        }
    }
    
    weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView, movies: [Movie]) {
        self.movies = movies
        self.collectionView = collectionView
        self.collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.movieListCell)
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.movieListCell, for: indexPath) as? MovieCollectionViewCell else {
            fatalError()
        }
        
        let movie = self.movies[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
    
}
