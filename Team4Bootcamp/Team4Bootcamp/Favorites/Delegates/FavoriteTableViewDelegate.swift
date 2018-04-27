//
//  FavoriteTableViewDelegate.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

typealias FavoriteTableViewCallback = ((IndexPath) -> Void)?

class FavoriteTableViewDelegate: NSObject, UITableViewDelegate {
    
    let callbackFromSelectedRow: FavoriteTableViewCallback
    
    init(selectedRowCallback: FavoriteTableViewCallback) {
        self.callbackFromSelectedRow = selectedRowCallback
        super.init()
    }
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callbackFromSelectedRow?(indexPath)
    }
}
