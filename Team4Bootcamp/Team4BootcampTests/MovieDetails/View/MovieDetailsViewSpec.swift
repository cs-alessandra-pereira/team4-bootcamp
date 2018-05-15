//
//  MovieDetailsViewSpec.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 14/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Team4Bootcamp

class MovieDetailsViewSpec: QuickSpec {
    override func spec() {
        describe("MovieDetailsView UI") {
            it("should have the expected look and feel") {
                let movie = Movie(id: 01, title: "Zootopia", releaseDate: nil, genres: [Genre(id: 12, name: "Adventure")], overview: "Blablablablabla blablablabla blabla blablablabla blablabla", posterPath: "/eKi8dIrr8voobb", persisted: false)
                let frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                let view = MovieDetailsView(frame: frame)
                let datasource = MovieDetailsDatasource(tableView: view.tableView, movie: movie)
                view.tableView.dataSource = datasource
                view.imageView.backgroundColor = .black
                expect(view) == snapshot("MovieDetailsView")
            }
        }
    }
}
