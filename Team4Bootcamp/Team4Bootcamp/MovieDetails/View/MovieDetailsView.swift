//
//  MovieDetailsView.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 05/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
    
    static let movieDetailsCell = "MovieCell"
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = UIViewContentMode.scaleAspectFit
        view.backgroundColor = UIColor.white
        return view
    }()
    
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

extension MovieDetailsView: CodeView {
    
    func buildHierarchy() {
        addSubview(imageView)
        addSubview(tableView)
    }
    
    func buildConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.height.equalTo(300)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
        
    }
    
    func configure() {
        backgroundColor = UIColor.white
    }
}
