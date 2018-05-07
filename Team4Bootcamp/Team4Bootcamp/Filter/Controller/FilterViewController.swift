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
    private var favoriteMovies: [MovieDAO]? {
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
        filterView.tableView.delegate = self
        filterView.tableView.dataSource = self
    }
    
    func setupMovies(_ movies: [MovieDAO]?) {
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

extension FilterViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: FilterView.filterCell)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = FilterView.cellAgeLabel
            cell.detailTextLabel?.text = "None"
        } else {
            cell.textLabel?.text = FilterView.cellGenreLabel
            cell.detailTextLabel?.text = "None"
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

}

extension FilterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }

}
