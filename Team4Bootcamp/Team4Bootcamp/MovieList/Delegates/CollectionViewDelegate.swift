//
//  MovieListDelegate.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 04/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

typealias MovieCollectionViewCallback = (Movie) -> Void

protocol MovieCollectionViewDelegate: UICollectionViewDelegate {
    func didFavorite(image: String)
}

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    weak var datasource: MovieListDatasource?
    let callback: MovieCollectionViewCallback
    
    init(datasource: MovieListDatasource?, callback: @escaping MovieCollectionViewCallback) {
        self.datasource = datasource
        self.callback = callback
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let datasource = datasource {
            let movie = datasource.filteredMovieList[indexPath.row]
            callback(movie)
        }
    }
    
}
