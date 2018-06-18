//
//  MovieListController.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 14/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

enum MovieListState {
    case loading
    case success
    case error
    case noData
}

protocol MovieListViewHandler: class {
    var viewController: MovieListViewController { get }
    var state: MovieListState { get set }
}

class MovieListStatesController: MovieListViewHandler {
    
    var viewController: MovieListViewController
    var state: MovieListState = .loading {
        willSet(newState) {
            updateView(newState: newState)
        }
    }
    
    init(viewController controller: MovieListViewController) {
        viewController = controller
    }
    
    func loadingView() {
        viewController.collectionView.isHidden = true
        viewController.searchBar.isHidden = true
        viewController.activityIndicator.startAnimating()
        viewController.activityIndicator.isHidden = false
        viewController.viewNoResults.isHidden = true
        viewController.viewError.isHidden = true
    }
    
    func successView() {
        viewController.collectionView.isHidden = false
        viewController.searchBar.isHidden = false
        viewController.activityIndicator.stopAnimating()
        viewController.activityIndicator.isHidden = true
        viewController.viewNoResults.isHidden = true
        viewController.viewError.isHidden = true
    }
    
    func errorView() {
        viewController.collectionView.isHidden = true
        viewController.searchBar.isHidden = true
        viewController.activityIndicator.stopAnimating()
        viewController.activityIndicator.isHidden = true
        viewController.viewNoResults.isHidden = true
        viewController.viewError.isHidden = false
    }
    
    func noDataView() {
        viewController.collectionView.isHidden = true
        viewController.searchBar.isHidden = true
        viewController.activityIndicator.startAnimating()
        viewController.activityIndicator.isHidden = false
        viewController.viewNoResults.isHidden = true
        viewController.viewError.isHidden = true
    }
    
    func updateView(newState: MovieListState) {
        switch newState {
        case (.loading): loadingView()
        case (.success): successView()
        case (.error): errorView()
        case (.noData): noDataView()
        }
    }
}
