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
    
    let imageFetchable: ImageFetchable = KFImageFetchable()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = UIViewContentMode.scaleToFill
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.sizeToFit()
        view.textColor = UIColor.primaryColor
        view.numberOfLines = 2
        view.lineBreakMode = .byClipping
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = NSTextAlignment.center
        view.baselineAdjustment = .alignCenters
        return view
    }()
    
    lazy var iconButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(icon: .favGray), for: UIControlState.normal)
        view.setImage(UIImage(icon: .favFull), for: UIControlState.selected)
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
    
    func setup(movie: Movie) {
        textLabel.text = movie.title
        let path = MoviesConstants.Endpoints.moviePoster(movie.posterPath).path
        imageFetchable.fetch(imageURL: path, onImage: imageView) {}
    }
}

extension MovieCollectionViewCell: CodeView {
    
    func buildHierarchy() {
        addSubview(imageView)
        addSubview(iconButton)
        addSubview(textLabel)
        
    }
    
    func buildConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(frame.size.height*3/4)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalTo(self)
        }
        
        iconButton.snp.makeConstraints { make in
            make.height.equalTo(frame.size.height/12)
            make.topMargin.equalTo(imageView.snp.bottom).offset(25)
            make.right.equalTo(imageView.snp.rightMargin)
        }
        
        textLabel.snp.makeConstraints { make in
            make.width.equalTo(frame.size.width*6/8)
            make.right.equalTo(iconButton.snp.left)
            make.centerY.equalTo(iconButton.snp.centerY)
            make.left.equalTo(imageView.snp.leftMargin)
        }
    }
    
    func configure() {
        backgroundColor = UIColor.secondaryColor
    }
}
