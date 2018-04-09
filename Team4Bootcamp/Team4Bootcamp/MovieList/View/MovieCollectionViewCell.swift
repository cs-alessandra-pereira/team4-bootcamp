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

final class MovieCollectionViewCell: UICollectionViewCell {
    
    let imageFetchable: ImageFetchable = KFImageFetchable()
    
    static let movieListCell = "MovieCell"
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIViewContentMode.scaleAspectFit
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconButton = FavoriteButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(movie: Movie) {
        textLabel.text = movie.title
        let path = Endpoints.moviePoster(movie.posterPath).path
        imageFetchable.fetch(imageURLString: path, onImage: imageView) {}
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
            make.width.equalTo(frame.size.width)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
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
        
        textLabel.sizeToFit()
        textLabel.textColor = UIColor.primaryColor
        textLabel.numberOfLines = 2
        textLabel.lineBreakMode = .byClipping
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.baselineAdjustment = .alignCenters
    }
}
