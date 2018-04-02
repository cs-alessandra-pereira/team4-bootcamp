//
//  MovieCollectionViewCell.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 02/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = UIViewContentMode.scaleToFill
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = UIColor.primaryColor
        return view
    }()
    
    lazy var iconButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: UIControlState.normal)
        view.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: UIControlState.selected)
        view.contentMode = UIViewContentMode.scaleAspectFit
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

extension MovieCollectionViewCell: CodeView {
    
    func buildHierarchy() {
        addSubview(imageView)
        addSubview(textLabel)
        addSubview(iconButton)
        
    }
    
    func buildConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(frame.size.height*2/3)
        }
        
        iconButton.snp.makeConstraints { make in
            make.topMargin.equalTo(imageView.snp.bottom).offset(25)
            make.right.equalTo(imageView.snp.rightMargin)
        }
        
        textLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(imageView.snp.bottom).offset(25)
            make.left.equalTo(imageView.snp.leftMargin)
            make.right.equalTo(iconButton.snp.left)
        }
    
    }
    
    func configure() {
        backgroundColor = .darkGray
    }
}
