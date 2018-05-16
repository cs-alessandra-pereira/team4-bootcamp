//
//  MovieCollectionViewCell.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 15/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Nimble
import Quick
import Nimble_Snapshots

@testable import Team4Bootcamp

class MovieCollectionViewCellSpec: QuickSpec {
    
    override func spec() {
        describe("MovieCollectionViewCell UI") {

            it("Shoud behave as if the movie is not persisted") {
                
                let frame = CGRect(x: 0, y: 0, width: 180, height: 220)
                let sut = MovieCollectionViewCellStub(frame: frame)
                
                let movieNotPersisted = Movie(id: 01, title: "Zootopia", releaseDate: nil, genres: [], overview: "", posterPath: "", persisted: false)
                
                sut.setup(movie: movieNotPersisted, at: IndexPath(row: 0, section: 0))
                expect(sut) == snapshot("MovieCollectionViewCellNotPersisted")
            }
            
            it("Shoud behave as if the movie is persisted") {
                
                let frame = CGRect(x: 0, y: 0, width: 180, height: 220)
                let sut = MovieCollectionViewCellStub(frame: frame)
                
                let persisted = Movie(id: 02, title: "Coco", releaseDate: nil, genres: [], overview: "", posterPath: "", persisted: true)
                
                sut.setup(movie: persisted, at: IndexPath(row: 0, section: 0))
                expect(sut) == snapshot("MovieCollectionViewCellPersisted")
            }
        }
    }
}
