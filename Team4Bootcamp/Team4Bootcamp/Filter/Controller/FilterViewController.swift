//
//  FilterViewController.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 04/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var filterView = FilterView()
    var favoriteMovies: [MovieDAO]? {
        didSet {
            extractYearsFromMovies()
        }
    }
    var allGenreNames: [String] = []
    var allYears: [Int] = []
    var selectedGenreNames: [String] = []
    var selectedYears: [String] = []
    
    override func loadView() {
        self.view = filterView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupMovies(_ movies: [MovieDAO]) {
        self.favoriteMovies = movies
    }
    
    func extractYearsFromMovies() {
        if let movies = favoriteMovies {
            allYears = movies.map {Int($0.id)}
            allYears.sort()
        }
    }
    
    func extractGenreNamesFromMovies() {
        // TODO: Chamar banco pra retornar nomes únicos
    }
    
}

//extension FilterViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//}
//
//extension FilterViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//
//    }
//
//}
