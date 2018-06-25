//
//  FilterSelectorTableView.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 29/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Team4Bootcamp

class FilterSelectorTableViewSpec: QuickSpec {
    override func spec() {
        describe("FilterSelectorTableView UI") {
            it("should have the expected look and feel") {
                let mock = ["2018", "2016", "2015"]
                let frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                let controller = FilterSelectorViewController(nibName: nil, bundle: nil)
                let view = FilterSelectorTableView(frame: frame)
                view.tableView.register(FilterSelectorTableViewCell.self)
                view.tableView.dataSource = controller
                controller.data = mock
                expect(view) == snapshot("FilterSelectorTableView")
            }
        }
    }
}
