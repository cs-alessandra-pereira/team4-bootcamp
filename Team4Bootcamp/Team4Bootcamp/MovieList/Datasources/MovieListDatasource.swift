//
//  MovieListDatasource.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 03/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class MovieListDatasource: NSObject, UICollectionViewDataSource {
    let movies: [Movie]
    
    init(collectioView: UICollectionView, movies: [Movie]) {
        self.movies = movies
        super.init()
        collectioView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        }
        
        let movie = self.movies[indexPath.row]
        cell.setup(movie: movie)
        
        //if let imageURL = URL(string:movie.posterPath) {
        //    let imageResource = ImageResource(downloadURL: imageURL)
        //    cell.imageView.kf.setImage(with: imageResource)
        //}
        
        return cell
    }
}
