//
//  CollectionViewDelegateStub.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 13/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

@testable import Team4Bootcamp
import UIKit

class CollectionViewDelegateStub: CollectionViewDelegate {
    
    var didSelectCell = false
    var didLastCellAppeared = false
    var number = 0
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCell = true
        super.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionView.numberOfItems(inSection: moviesSection) - 1 {
            didLastCellAppeared = true
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        }
    }
}
