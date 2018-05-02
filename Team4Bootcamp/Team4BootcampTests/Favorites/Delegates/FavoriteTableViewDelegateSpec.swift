//
//  FavoriteTableViewDelegateSpec.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 24/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Team4Bootcamp

class FavoriteTableViewDelegateSpec: QuickSpec {
    
    override func spec() {
        
       var tableView: UITableView!
       var indexPath: IndexPath!
       var sut: FavoriteTableViewDelegateStub!
       
       describe("FavoriteTableViewDelegate") {
           beforeEach {
               tableView = UITableView(frame: .zero)
               indexPath = IndexPath(row: 1, section: 0)
               sut = FavoriteTableViewDelegateStub()
               tableView.delegate = sut
           }
           
           context("responding to FavoriteTableViewDelegate", closure: {
               
               it("should return true if user select cell as setted on indexPath") {
                   expect(sut.didSelectCell) == false
                   expect(sut.touchedCellIndex) == IndexPath(row: 0, section: 0)
                   sut.tableView(tableView, didSelectRowAt: indexPath)
                   expect(sut.touchedCellIndex) == IndexPath(row: 1, section: 0)
                   expect(sut.didSelectCell) == true
               }
           })
       }
    }
}
