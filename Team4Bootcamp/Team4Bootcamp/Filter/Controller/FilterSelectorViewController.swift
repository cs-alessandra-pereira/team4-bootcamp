//
//  FilterSelectorViewController.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 07/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

typealias FilterSelectionCallback = ([String]) -> Void

class FilterSelectorViewController: UIViewController {
    
    let filterSelectorCell = "SelectorCell"

    private var filterSelectorTableView = FilterSelectorTableView()
    var data: [String] = []
    private var selectedData: [String] = []

    var filterSelectedCallback: FilterSelectionCallback?
    
    override func loadView() {
        self.view = filterSelectorTableView
    }
    override func viewDidLoad() {
        filterSelectorTableView.tableView.delegate = self
        filterSelectorTableView.tableView.dataSource = self
        filterSelectorTableView.tableView.register(FilterSelectorTableViewCell.self, forCellReuseIdentifier: filterSelectorCell)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil, let callback = filterSelectedCallback {
            callback(selectedData)
        }
    }
}

extension FilterSelectorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: filterSelectorCell, for: indexPath) as? FilterSelectorTableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = data[indexPath.row]
        for element in selectedData where element == data[indexPath.row] {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
        return cell
    }
}

extension FilterSelectorViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedData.append(data[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        for (index, element) in selectedData.enumerated() where element == data[indexPath.row] {
            self.selectedData.remove(at: index)
        }
    }
}
