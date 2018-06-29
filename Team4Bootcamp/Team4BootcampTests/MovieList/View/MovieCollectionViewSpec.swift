//
//  MovieCollectioViewSpec.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 25/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Team4Bootcamp

class MovieCollectionViewSpec: QuickSpec {
    override func spec() {
        describe("MovieCollectionView UI") {
            it("should have the expected look and feel") {
                
                let frame = CGRect(x: 0, y: 0, width: 414, height: 567)
                var movieListDatasource: MovieCollectioViewStub?
                let sut = MovieCollectionView(frame: frame)
                
                movieListDatasource = MovieCollectioViewStub(collectionView: sut)
                sut.dataSource = movieListDatasource
                
                expect(sut) == snapshot("MovieCollectionView")
            }
        }
    }
}
