//
//  TabBarDelegate.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 01/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

typealias TabBarCallback = ((TabBarEvent) -> Void)?

class TabBarDelegate: NSObject, UITabBarControllerDelegate {
    
    let movieCollectionListItem = 0
    let favoriteMoviesListItem = 1
    
    var callbackFromSelectedTabBarItem: TabBarCallback = nil
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
        case movieCollectionListItem:
            callbackFromSelectedTabBarItem?(TabBarEvent.firstItemSelected)
        case favoriteMoviesListItem:
            callbackFromSelectedTabBarItem?(TabBarEvent.secondItemSelected)
        default:
            break
        }
    }
}

enum TabBarEvent {
    case firstItemSelected
    case secondItemSelected
}
