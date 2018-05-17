//
//  FilterOptionsView.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 04/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class FilterSelectorTableView: UIView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.allowsMultipleSelection = true
        view.tableFooterView = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterSelectorTableView: CodeView {
    
    func buildHierarchy() {
        addSubview(tableView)
    }
    
    func buildConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
        
    }
    
    func configure() {
        backgroundColor = UIColor.white
    }
}
