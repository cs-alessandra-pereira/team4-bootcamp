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
    var selectedGenreNames: [String] = []
    var selectedYears: [String] = []
    
    override func loadView() {
        self.view = filterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.tableView.delegate = self
        filterView.tableView.dataSource = self
        filterView.delegate = self
        
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
        var data: [String] = []
        
        data = indexPath.row == 0 ? selectedYears : selectedGenreNames
        cell.textLabel?.text = indexPath.row == 0 ? FilterView.cellAgeLabel : FilterView.cellGenreLabel
        
        cell.detailTextLabel?.text = data.first ?? ""
        if data.count > 1 {
            cell.detailTextLabel?.text = (cell.detailTextLabel?.text ?? "") + "..."
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension FilterViewController: UITableViewDelegate, FilterViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filterSelectorVC = FilterSelectorViewController()
        var data: [String] = []
        
        filterSelectorVC.data = indexPath.row == 0 ? allYears : allGenreNames
        data = indexPath.row == 0 ? selectedYears : selectedGenreNames
        filterSelectorVC.selectedData = data.count > 0 ? data : []
        
        filterSelectorVC.filterSelectedCallback = { [weak self] selectedData in
            indexPath.row == 0 ? (self?.selectedYears = selectedData) : (self?.selectedGenreNames = selectedData)
            self?.filterView.tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(filterSelectorVC, animated: true)
    }
    
    func applyFilter() {
        guard let vcs = self.navigationController?.viewControllers else {
            fatalError()
        }
        for item in vcs where item.isKind(of: FavoritesViewController.self) {
            guard let favoritesVC = item as? FavoritesViewController else {
                fatalError()
            }
            favoritesVC.favoritesDataSouce?.yearToFilter = self.selectedYears
            favoritesVC.favoritesDataSouce?.genresToFilter = self.selectedGenreNames
        }
        self.navigationController?.popViewController(animated: true)
        
        //TODO: Tá atualizando no FavoritesDataSource duas listas de Strings a partir daquelas
        //selecionadas no filtro. Mas ainda não tá realizando o filtro.
    }
}
