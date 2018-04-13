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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCell = true
    }
}
