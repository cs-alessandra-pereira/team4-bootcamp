//
//  FilterView.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 04/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class FilterView: UIView {

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.allowsSelection = false
        view.alwaysBounceVertical = false
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

extension FilterView: CodeView {
    func buildHierarchy() {
        addSubview(tableView)
    }
    
    func buildConstraints() {
        tableView.snp.makeConstraints { make in
            //make.left.equalTo(self)
            //make.right.equalTo(self)
            make.size.equalTo(self)
        }
    }
}
