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
            allYears = extractYearsFromMovies().sorted()
        }
    }
    fileprivate var allGenreNames: [String] = []
    fileprivate var allYears: [String] = []
    fileprivate var selectedGenreNames: [String] = []
    fileprivate var selectedYears: [String] = []
    
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
    
    func extractYearsFromMovies() -> [String] {
        var years: [String] = []
        if let movies = favoriteMovies {
            _ = movies.map { movie in
                if let nsdate = movie.date, let date = nsdate as Date? {
                    let year = Date.releaseYearAsString(date)
                    if !years.contains(year) {
                        years.append(year)
                    }
                }
            }
        }
        return years
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
            cell.detailTextLabel?.text = selectedYears.first ?? ""
        } else {
            cell.textLabel?.text = FilterView.cellGenreLabel
            cell.detailTextLabel?.text =  selectedGenreNames.first ?? ""
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filterSelectorVC = FilterSelectorViewController()
        
        filterSelectorVC.data = indexPath.row == 0 ? allYears : []
        filterSelectorVC.filterSelectedCallback = { [weak self] selectedData in
            indexPath.row == 0 ? (self?.selectedYears = selectedData) : (self?.selectedGenreNames = selectedData)
            self?.filterView.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(filterSelectorVC, animated: true)
    }
}
