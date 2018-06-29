//
//  FavoriteDataSourceStub.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 24/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

@testable import Team4Bootcamp
import UIKit
import CoreData

class FavoritesDataSourceStub: FavoritesDataSource {
    
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
    var numberOfMovies = 0
    var moviesTest: [MovieDAO] = []
    let movie = Movie(id: 337167, title: "Fifty Shades Freed", releaseDate: Date(), genresIds: [], overview: "", posterPath: "/jjPJ4s3DWZZvI4vw8Xfi4Vqa1Q8.jpg", persisted: false)
    
    override init(tableView: UITableView, searchBarDelegate: SearchBarDelegate?) {
        super.init(tableView: tableView, searchBarDelegate: searchBarDelegate)
        self.addTestMovieToDB(movies: moviesTest)
    }

    func addTestMovieToDB(movies mvs: [MovieDAO]) {
        let context = self.mockPersistantContainer.viewContext
        let newMovieDAO = MovieDAO(context: context)
        newMovieDAO.date = movie.releaseDate as NSDate?
        newMovieDAO.id = Int32(movie.id)
        newMovieDAO.overview = movie.overview
        newMovieDAO.title = movie.title
        newMovieDAO.posterPath = movie.posterPath
        newMovieDAO.genres = []
        moviesTest.append(newMovieDAO)
    }
    
    override func setupFetchedResultController(withPredicate predicate: NSPredicate?) {
        super.setupFetchedResultController()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies = moviesTest
        numberOfMovies = super .tableView(tableView, numberOfRowsInSection: section)
        return numberOfMovies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        movies = moviesTest
        return super .tableView(tableView, cellForRowAt: indexPath)
    }
    
}
