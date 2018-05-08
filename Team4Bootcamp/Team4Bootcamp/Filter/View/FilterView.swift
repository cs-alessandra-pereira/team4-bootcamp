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
    
    lazy var applyFilterButton: UIButton = {
        let view = UIButton(type: .system)
        view.addTarget(self, action: #selector(didTouchApplyFilterButton), for: .touchUpInside)
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
        addSubview(applyFilterButton)
    }
    
    func buildConstraints() {
        tableView.snp.makeConstraints { make in
            //make.left.equalTo(self)
            //make.right.equalTo(self)
            make.size.equalTo(self)
        }
        applyFilterButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).inset(10)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(10)
            make.height.equalTo(60)
            
        }
    }
    
    func  configure() {
        applyFilterButton.layer.backgroundColor = UIColor.primaryColor?.cgColor
        applyFilterButton.layer.masksToBounds = true
        applyFilterButton.layer.cornerRadius = 5
        applyFilterButton.setTitle("Apply", for: .normal)
        applyFilterButton.setTitleColor(UIColor.white, for: .normal)
        applyFilterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
    }
}

extension FilterView {
    @objc
    fileprivate func didTouchApplyFilterButton() {
        //TODO: Aplica filtro
    }
}
