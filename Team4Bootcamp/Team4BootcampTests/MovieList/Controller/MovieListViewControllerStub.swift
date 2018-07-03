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
    
    var setupDelegatesWasCalled = false
    var fetchGenresWasCalled = false
    var fetchMoviesWasCalled = false
    var setupDatasourceWasCalled = false
    
    override func setupDelegates() {
        setupDelegatesWasCalled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func fetchGenres() {
        fetchGenresWasCalled = true
        super.fetchGenres()
    }
    
    override func fetchMovies() {
        fetchMoviesWasCalled = true
    }
    
    override func setupDatasource() {
        setupDatasourceWasCalled = true
    }
    
    
}
