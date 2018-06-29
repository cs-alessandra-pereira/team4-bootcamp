//
//  FavoritesDataSourceSpec.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 24/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import CoreData
import Quick
import Nimble

@testable import Team4Bootcamp

class FavoritesDataSourceSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        let searchBarDelegate = SearchBarDelegate()
        var sut: FavoritesDataSource!
        var indexPath: IndexPath!
        
        describe("FavoriteDatasource") {
            beforeEach {
                tableView = UITableView(frame: .zero)
                sut = FavoritesDataSource.init(tableView: tableView, searchBarDelegate: searchBarDelegate)
                tableView.dataSource = sut
            }
            
            context("responding to FavoriteDatasource", closure: {
                
                var sut: FavoritesDataSourceStub!
                
                beforeEach {
                    sut = FavoritesDataSourceStub(tableView: tableView, searchBarDelegate: searchBarDelegate)
                    indexPath = IndexPath(row: 0, section: 0)
                }
                
                it("should return true if initialized correctly") {
                    expect(sut).to(beAnInstanceOf(FavoritesDataSourceStub.self))
                    
                }
                it("should return true if return the expected movie") {
                    expect(sut.searchString).to(beNil())
                    sut.searchString = "Incredibles 2"
                    let movies = sut.fetchedResultsController?.fetchedObjects
                    expect(sut.searchString) == (movies?[0].title)
                }
                
                it("should return true if numberOfMovies changes conforme expected and number of rows is equal to one") {
                    expect(sut.numberOfMovies) == 0
                    //expect(sut.tableView(tableView, numberOfRowsInSection: indexPath.section)) == 1
                    //expect(sut.numberOfMovies) == 1
                    
                }
                it("should return a valid cell of expected type") {
                    let cell = sut.tableView(tableView, cellForRowAt: indexPath)
                    expect(cell).to(beAKindOf(FavoriteTableViewCell.self))
                }
                
                
            })
        }
    }
}
