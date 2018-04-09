//
//  MovieListDelegate.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 04/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class MovieListDelegate: NSObject, UICollectionViewDelegate {
    
    let viewController: MovieListViewController
    
    init(viewController: MovieListViewController) {
        self.viewController = viewController
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = viewController.movies[indexPath.row]
        viewController.proceedToDetailsView(movie: movie)
    }
    
}
