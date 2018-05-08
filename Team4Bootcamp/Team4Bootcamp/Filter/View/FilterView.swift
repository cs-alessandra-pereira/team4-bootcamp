//
//  FilterView.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 04/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class FilterView: UIView {

    static let filterCell = "FilterCell"
    static let cellAgeLabel = "Ano"
    static let cellGenreLabel = "Gênero"
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.alwaysBounceVertical = false
        view.separatorStyle = UITableViewCellSeparatorStyle.none
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
