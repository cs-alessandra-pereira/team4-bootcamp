//
//  SearchBarDelegate.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 10/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

typealias SearchBarCallback = ((UISearchBar, SearchBarEvent, String?) -> Void)?

class SearchBarDelegate: NSObject, UISearchBarDelegate {
    
    var callback: SearchBarCallback = nil
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        callback?(searchBar, SearchBarEvent.textChanged, searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        callback?(searchBar, SearchBarEvent.cancelled, nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callback?(searchBar, SearchBarEvent.posted, nil)
    }
}

enum SearchBarEvent {
    case textChanged
    case cancelled
    case posted
}
