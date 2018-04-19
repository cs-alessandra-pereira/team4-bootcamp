//
//  MovieListDelegate.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 04/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

typealias MovieCollectionViewCallback = ((CollectionViewEvent, Int) -> Void)?

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {

    let moviesSection = 0
    var callback: MovieCollectionViewCallback = nil
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callback?(CollectionViewEvent.didSelectItemAt, indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionView.numberOfItems(inSection: moviesSection) - 1 {
            callback?(CollectionViewEvent.willDisplayMoreCells, indexPath.row)
        }
    }
}

enum CollectionViewEvent {
    case didSelectItemAt
    case willDisplayMoreCells
}
