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
        let frc = NSFetchedResultsController<MovieDAO>()
        
        describe("FavoriteDatasource") {
            beforeEach {
                tableView = UITableView(frame: .zero)
                sut = FavoritesDataSource.init(tableView: tableView, fetchedResults: frc, searchBarDelegate: searchBarDelegate)
                tableView.dataSource = sut
            }
            
            context("responding to FavoriteDatasource", closure: {
                
                var sut: FavoritesDataSourceStub!
                
                beforeEach {
                    sut = FavoritesDataSourceStub(tableView: tableView, fetchedResults: frc, searchBarDelegate: searchBarDelegate)
                }
                
                it("should return true if initialized correctly") {
                    expect(sut).to(beAnInstanceOf(FavoritesDataSourceStub.self))
                    
                }
                it("should return true if number of rows is equal to zero and numberOfMovies changes conforme expected") {
                    expect(sut.numberOfMovies) == 0
                    expect(sut.tableView(tableView, numberOfRowsInSection: 0)) == 0
                    expect(sut.numberOfMovies) == 20
                }
            })
        }
    }
}
