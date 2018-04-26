//
//  FavoritesViewController.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 26/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

@testable import Team4Bootcamp
import Foundation

class FavoritesViewControllerStub : FavoritesViewController {
    
    var setupNSFetchedWasCalled = false
    var setupDelegateWasCalled = false
    var setupDataSourceWasCalled = false
    
    override func setupNSFetched() {
        setupNSFetchedWasCalled = true
    }
    
    override func setupDelegate() {
        setupDelegateWasCalled = true
    }
    
    override func setupDataSource(movies: [Movie]) {
        setupDataSourceWasCalled = true
    }
    
}
