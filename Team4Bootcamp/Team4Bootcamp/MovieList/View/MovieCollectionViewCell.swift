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

protocol MovieCollectionViewCellDelegate: class {
    func didFavoriteCell(_ isSelected: Bool, at position: IndexPath)
}

class MovieCollectionViewCell: UICollectionViewCell, Reusable {
    
    static var nibName: UINib?
    
    let imageFetchable: ImageFetchable = KFImageFetchable()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIViewContentMode.scaleToFill
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var delegate: MovieCollectionViewCellDelegate?
    var position: IndexPath?
    
    lazy var iconButton: FavoriteButton = {
        let view = FavoriteButton(frame: .zero)
        
        view.addTarget(self, action: #selector(didTouchFavoriteButton), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(movie: Movie, at position: IndexPath) {
        textLabel.text = movie.title
        if movie.persisted {
            iconButton.isSelected = true
        } else {
            iconButton.isSelected = false
        }
        self.position = position
        let path = Endpoint.moviePoster(movie.posterPath).path
        imageFetchable.fetch(imageURLString: path, onImage: imageView) {}
    }
}

extension MovieCollectionViewCell {
    @objc
    fileprivate func didTouchFavoriteButton() {
        if let cellPosition = position {
            iconButton.isSelected = iconButton.isSelected ? false : true
            delegate?.didFavoriteCell(iconButton.isSelected, at: cellPosition)
        }
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
            make.width.equalTo(frame.size.width*3/4)
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
