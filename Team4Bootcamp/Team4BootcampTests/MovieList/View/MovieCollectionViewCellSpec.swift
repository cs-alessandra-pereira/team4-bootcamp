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
                
                let frame = CGRect(x: 0, y: 0, width: 100, height: 120)
                let sut = MovieCollectionViewCell(frame: frame)
                
                let movieNotPersisted = Movie(id: 01, title: "Zootopia", releaseDate: nil, genres: [], overview: "", posterPath: "/eKi8dIrr8voobb", persisted: false)
                
                sut.setup(movie: movieNotPersisted, at: IndexPath(row: 0, section: 0))
                expect(sut) == snapshot("MovieCollectionViewCellNotPersisted")
            }
            
            it("Shoud behave as if the movie is persisted") {
                
                let frame = CGRect(x: 0, y: 0, width: 100, height: 120)
                let sut = MovieCollectionViewCell(frame: frame)
                
                let persisted = Movie(id: 01, title: "Zootopia", releaseDate: nil, genres: [], overview: "", posterPath: "/eKi8dIrr8voobb", persisted: true)
                
                sut.setup(movie: persisted, at: IndexPath(row: 0, section: 0))
                expect(sut) == snapshot("MovieCollectionViewCellPersisted")
            }
            
        }
    }
}
