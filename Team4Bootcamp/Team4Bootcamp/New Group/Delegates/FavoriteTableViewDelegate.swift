//
//  FavoriteTableViewDelegate.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

typealias FavoriteTableViewCallback = ((TableViewEvent, Int) -> Void)?

class FavoriteTableViewDelegate: NSObject, UITableViewDelegate {
    
    var callback: FavoriteTableViewCallback = nil
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callback?(TableViewEvent.didSelectItemAt, indexPath.row)
    }
}

enum TableViewEvent {
    case didSelectItemAt
}
