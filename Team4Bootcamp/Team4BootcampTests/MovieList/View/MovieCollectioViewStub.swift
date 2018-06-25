//
//  MovieCollectioViewStub.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 25/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

@testable import Team4Bootcamp
import UIKit

final class MovieCollectioViewStub: NSObject, UICollectionViewDataSource {
    
    var movie: Movie!
    var movies: [Movie]!
    weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.movie = Movie(id: 01, title: "Zootopia", releaseDate: nil, genresIds: [12], overview: "Blablablablabla blablablabla blabla blablablabla blablabla", posterPath: "/eKi8dIrr8voobb", persisted: false)
        self.movies = [movie, movie, movie, movie, movie, movie]
        self.collectionView?.register(MovieCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(movie: movie, at: indexPath)
        return cell
    }
    
}
