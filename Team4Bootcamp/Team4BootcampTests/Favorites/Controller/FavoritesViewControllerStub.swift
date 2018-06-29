//
//  FavoritesViewController.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 26/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import UIKit
@testable import Team4Bootcamp

class FavoritesViewControllerStub: FavoritesViewController {
    
    var setupDataSourceWasCalled = false
    var setupDelegateWasCalled = false
    var setupSearchBarWasCalled = false
    
    override func setupDataSource() {
        setupDataSourceWasCalled = true
    }
    
    override func setupDelegate() {
        setupDelegateWasCalled = true
    }
    
    override func setupSearchBar() {
        setupSearchBarWasCalled = true
    }
    
    static func initFromStoryboard() -> FavoritesViewController {
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle(for: FavoritesViewController.self))
        
        let className = String.init(describing: FavoritesViewController.self)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: className) as? FavoritesViewController else {
            fatalError("Could not load controller called \(className)")
        }
        return viewController
    }
}
