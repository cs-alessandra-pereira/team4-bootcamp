//
//  MovieDetailsView.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 05/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

protocol MovieDetailFavoriteDelegate: class {
    func didFavoriteMovie(_ isSelected: Bool)
}

class MovieDetailsView: UIView {
    
    static let movieDetailsCell = "MovieCell"
    var persistedButtonDelegate: MovieDetailFavoriteDelegate?
    
    lazy var posterImage: UIImageView = {
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
    
    lazy var persistedButton: FavoriteButton = {
        let view = FavoriteButton(frame: .zero)
        view.addTarget(self, action: #selector(didFavoriteMovie), for: .touchUpInside)
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

extension MovieDetailsView {
    @objc
    fileprivate func didFavoriteMovie() {
        persistedButton.isSelected = persistedButton.isSelected ? false : true
        persistedButtonDelegate?.didFavoriteMovie(persistedButton.isSelected)
    }
}

extension MovieDetailsView: CodeView {
    
    func buildHierarchy() {
        addSubview(posterImage)
        addSubview(tableView)
        addSubview(persistedButton)
    }
    
    func buildConstraints() {
        
        posterImage.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.height.equalTo(300)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(posterImage.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
        
        persistedButton.snp.makeConstraints { make in
            make.top.equalTo(tableView).offset(12)
            make.right.equalTo(tableView).inset(12)
            make.width.equalTo(25)
        }
    }
    
    func configure() {
        backgroundColor = UIColor.white
    }
}
