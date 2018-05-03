//
//  FavoriteTableViewDelegateStub.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 24/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

@testable import Team4Bootcamp
import UIKit

class FavoriteTableViewDelegateStub: FavoriteTableViewDelegate {
    
    var didSelectCell = false
    var touchedCellIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        touchedCellIndex = indexPath
        didSelectCell = true
        super .tableView(tableView, didSelectRowAt: indexPath)
    }
    
}
