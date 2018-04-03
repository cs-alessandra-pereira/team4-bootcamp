//
//  MovieListViewController.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 28/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var movieService: MoviesServiceProtocol = MoviesAPI()
    var movies: [Movie] = [] {
        didSet {
            setupDatasource()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupCollectionView()
    }

    func setupCollectionView() {
        let insets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = insets
        layout.itemSize = CGSize(width: 180, height: 220)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = UIColor.white
    }
    
    func setupDatasource() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func fetchMovies() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.collectionView.isHidden = true
        movieService.fetchMovies { movies in
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.movies = movies
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MovieListViewController: UICollectionViewDataSource {
    //collectionView(_:numberOfItemsInSection:) and collectionView(_:cellForItemAt:)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MovieCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        }
        
        let movie = self.movies[indexPath.row]
        cell.setup(movie: movie)
        
        //if let imageURL = URL(string:movie.posterPath) {
        //    let imageResource = ImageResource(downloadURL: imageURL)
        //    cell.imageView.kf.setImage(with: imageResource)
        //}

        return cell
    }
    
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}
