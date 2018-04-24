//
//  CollectionViewDelegateSpec.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 12/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Team4Bootcamp

class CollectionViewDelegateSpec: QuickSpec {
    
    override func spec() {
        
        var collectionView: UICollectionView!
        var layout: UICollectionViewLayout!
        var indexPath: IndexPath!
        var cell: MovieCollectionViewCell!
        var sut: CollectionViewDelegateStub!
        
        describe("CollectionViewDelegate") {
            beforeEach {
                layout = UICollectionViewFlowLayout()
                collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
                indexPath = IndexPath(row: 0, section: 0)
                cell = MovieCollectionViewCell()
                sut = CollectionViewDelegateStub()
                collectionView.delegate = sut
            }
            
            context("responding to CollectionViewDelegate", closure: {
                
                it("should return true if user select cell") {
                    expect(sut.didSelectCell) == false
                    sut.collectionView(collectionView, didSelectItemAt: indexPath)
                    expect(sut.didSelectCell) == true
                }
            })
        }
    }
}
