//
//  MovieCollectionView.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 13/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MovieCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        let screenSize = UIScreen.main.bounds
        let insets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = insets
        layout.estimatedItemSize = CGSize(width: screenSize.width*3/7, height: 220)
        self.collectionViewLayout = layout
        self.backgroundColor = UIColor.white
    }
    
}
