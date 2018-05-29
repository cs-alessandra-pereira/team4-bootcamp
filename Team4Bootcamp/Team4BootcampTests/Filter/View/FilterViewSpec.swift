//
//  FilterView.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 29/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import Team4Bootcamp

class FilterViewSpec: QuickSpec {
    override func spec() {
        describe("FilterView UI") {
            it("should have the expected look and feel without data selected") {
                let frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                let controller = FilterViewController(nibName: nil, bundle: nil)
                let view = FilterView(frame: frame)
                view.tableView.register(FilterSelectorTableViewCell.self, forCellReuseIdentifier: "SelectorCell")
                view.tableView.dataSource = controller
                expect(view) == snapshot("FilterViewWithoutData")
            }
            
            it("should have the expected look with one for each filter selected") {
                let frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                let controller = FilterViewController(nibName: nil, bundle: nil)
                controller.selectedYears = ["2018"]
                controller.selectedGenreNames = ["Romance"]
                let view = FilterView(frame: frame)
                view.tableView.register(FilterSelectorTableViewCell.self, forCellReuseIdentifier: "SelectorCell")
                view.tableView.dataSource = controller
                expect(view) == snapshot("FilterViewWithOneDataSelected")
            }
            
            it("should have the expected look with one for each filter selected") {
                let frame = CGRect(x: 0, y: 0, width: 414, height: 736)
                let controller = FilterViewController(nibName: nil, bundle: nil)
                controller.selectedYears = ["2018", "2016"]
                controller.selectedGenreNames = ["Romance", "Action"]
                let view = FilterView(frame: frame)
                view.tableView.register(FilterSelectorTableViewCell.self, forCellReuseIdentifier: "SelectorCell")
                view.tableView.dataSource = controller
                expect(view) == snapshot("FilterViewWithTwoDatasSelected")
            }
        }
    }
}
