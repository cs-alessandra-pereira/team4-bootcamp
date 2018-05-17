//
//  MovieListViewControllerStub.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 16/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
@testable import Team4Bootcamp

final class MovieListViewControllerStub: MovieListViewController {
    
    var setupDelegateWasCalled = false
    var setupSearchBarWasCalled = false
    var fetchGenresWasCalled = false
    var fetchMoviesWasCalled = false
    var setupDatasourceWasCalled = false
    
    override func setupDelegate() {
        setupDelegateWasCalled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func setupSearchBar() {
        setupSearchBarWasCalled = true
    }
    
    override func fetchGenres() {
        fetchGenresWasCalled = true
    }
    
    override func fetchMovies() {
        fetchMoviesWasCalled = true
    }
    
    override func setupDatasource(movies: [Movie], searchBarDelegate: SearchBarDelegate?) {
        setupDatasourceWasCalled = true
    }
    
    
}
