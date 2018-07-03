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
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: PersistenceConstants.persistenceContainerName)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        
        return container
    }()
    
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
                    let movieListViewController = MovieListViewController()
                    movieListViewController.fetchGenres()
                    
                    let movie = Movie(id: 01, title: "Zootopia", releaseDate: nil, genresIds: [12], overview: "Blablablablabla blablablabla blabla blablablabla blablabla", posterPath: "/eKi8dIrr8voobb", persisted: false)
                    MovieDAO.addMovie(movie: movie, context: self.mockPersistantContainer.viewContext)
                    
                    sut = FavoritesDataSourceStub(tableView: tableView, searchBarDelegate: searchBarDelegate)
                    sut.container = self.mockPersistantContainer
                    sut.performNewFetch()
                    indexPath = IndexPath(row: 0, section: 0)
                }
                
                it("should return true if initialized correctly") {
                    expect(sut).to(beAnInstanceOf(FavoritesDataSourceStub.self))
                    
                }
                it("should return true if return the expected movie") {
                    expect(sut.searchString).to(beNil())
                    sut.searchString = "Zootopia"
                    let movies = sut.fetchedResultsController?.fetchedObjects
                    expect(sut.searchString) == (movies?[0].title)
                }
                
                it("should return true if numberOfMovies changes conforme expected and number of rows is equal to one") {
                    expect(sut.numberOfMovies) == 0
                    expect(sut.tableView(tableView, numberOfRowsInSection: indexPath.section)) == 1
                    expect(sut.numberOfMovies) == 1
                    
                }
                it("should return a valid cell of expected type") {
                    let cell = sut.tableView(tableView, cellForRowAt: indexPath)
                    expect(cell).to(beAKindOf(FavoriteTableViewCell.self))
                }
                
                
            })
        }
    }
}
