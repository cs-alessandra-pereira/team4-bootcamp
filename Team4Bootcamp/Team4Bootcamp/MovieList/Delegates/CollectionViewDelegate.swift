//
//  MovieListDelegate.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 04/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    weak var viewController: MovieListViewController?
    
    init(viewController: MovieListViewController) {
        self.viewController = viewController
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let controller = viewController {
            let movie = controller.filteredMovies()[indexPath.row]
            controller.proceedToDetailsView(movie: movie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let data = viewController?.filteredMovies().count, indexPath.row == data - 1 {
            if MoviesConstants.pageBaseURL <= MoviesConstants.paginationLimit {
                viewController?.fetchMovies()
            }
        }
    }
    
}
