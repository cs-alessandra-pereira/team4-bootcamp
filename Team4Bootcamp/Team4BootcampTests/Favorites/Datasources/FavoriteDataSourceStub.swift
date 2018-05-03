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

    var numberOfMovies = 0
    var moviesTest: [MovieDAO] = []
    let movie = Movie(id: 337167, title: "Fifty Shades Freed", releaseDate: Date(), genres: [], overview: "", posterPath: "/jjPJ4s3DWZZvI4vw8Xfi4Vqa1Q8.jpg", persisted: false)
    
    override init(tableView: UITableView, fetchedResults: NSFetchedResultsController<MovieDAO>, searchBarDelegate: SearchBarDelegate?) {
        super.init(tableView: tableView, fetchedResults: fetchedResults, searchBarDelegate: searchBarDelegate)
    }
    
    override func filteredList(movies mvs: [MovieDAO]) -> [MovieDAO] {
        guard let context = container?.viewContext else {
            return []
        }
        let newMovieDAO = MovieDAO(context: context)
        newMovieDAO.date = movie.releaseDate as NSDate?
        newMovieDAO.id = Int32(movie.id)
        newMovieDAO.overview = movie.overview
        newMovieDAO.title = movie.title
        newMovieDAO.posterPath = movie.posterPath
        newMovieDAO.genres = []
        moviesTest.append(newMovieDAO)

        return super.filteredList(movies: moviesTest)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfMovies = super .tableView(tableView, numberOfRowsInSection: section)
        return numberOfMovies
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return super .tableView(tableView, cellForRowAt: indexPath)
    }
    
}
