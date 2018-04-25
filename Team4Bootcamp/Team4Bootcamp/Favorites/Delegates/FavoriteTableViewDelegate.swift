//
//  FavoriteTableViewDelegate.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

typealias FavoriteTableViewCallback = ((TableViewEvent, IndexPath) -> Void)?

class FavoriteTableViewDelegate: NSObject, UITableViewDelegate {
    //FIXME: Tales - esse valor pode ser alterado? caso negativo, mude pra let e crie um init passando o valor
    var callback: FavoriteTableViewCallback = nil
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callback?(TableViewEvent.didSelectItemAt, indexPath)
    }
}

enum TableViewEvent {
    case didSelectItemAt
}
