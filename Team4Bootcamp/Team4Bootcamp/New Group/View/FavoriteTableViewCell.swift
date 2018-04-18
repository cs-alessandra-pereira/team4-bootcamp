//
//  FavoriteTableViewCell.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 17/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

final class FavoriteTableViewCell: UITableViewCell {
    
    private let imageFetchable: ImageFetchable = KFImageFetchable()
    private let calendar = Calendar.current
    
    lazy var posterImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIViewContentMode.scaleAspectFit
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var overview: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var date: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    static let reuseIdentifier = "FavoriteTableViewCell"
    static let cellHeight = 100
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(movie: MovieDAO) {
        title.text = movie.title
        overview.text = movie.overview
        if let movieDate = movie.date as Date? {
            date.text = String(calendar.component(.year, from: movieDate))
        }
        let path = Endpoints.moviePoster(movie.posterPath).path
        imageFetchable.fetch(imageURLString: path, onImage: posterImage) {}
    }
    
}

extension FavoriteTableViewCell: CodeView {
    
    private var availableCellHeight: Int {
        return FavoriteTableViewCell.cellHeight - 2*CellConstants.standardPaddingValue
    }
    
    func buildHierarchy() {
        addSubview(posterImage)
        addSubview(title)
        addSubview(overview)
        addSubview(date)
    }
    
    func buildConstraints() {

        posterImage.snp.makeConstraints { make in
            make.width.equalTo(availableCellHeight*2/3)
            make.left.equalTo(self.snp.left).offset(CellConstants.standardPaddingValue)
            make.top.equalTo(self.snp.top).offset(CellConstants.standardPaddingValue)
            make.bottom.equalTo(self.snp.bottom).offset(-CellConstants.standardPaddingValue)
        }
        
        overview.snp.makeConstraints { make in
            make.left.equalTo(posterImage.snp.right).offset(CellConstants.standardPaddingValue)
            make.right.equalTo(self.snp.right).offset(-CellConstants.standardPaddingValue)
            make.bottom.equalTo(self.snp.bottom).offset(-CellConstants.standardPaddingValue)
            make.top.equalTo(title.snp.bottom).offset(CellConstants.standardPaddingValue)
        }
        
        date.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.top)
            make.right.equalTo(self.snp.right).offset(-CellConstants.standardPaddingValue)
            make.width.equalTo(45)
            make.height.equalTo(availableCellHeight*1/5)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(CellConstants.standardPaddingValue)
            make.left.equalTo(posterImage.snp.right).offset(CellConstants.standardPaddingValue)
            make.height.equalTo(availableCellHeight*1/5)
            make.right.equalTo(date.snp.left).offset(-CellConstants.standardPaddingValue)
        }
        
        
    }
    
    func configure() {
        backgroundColor = UIColor.terciaryColor
        
        //title.sizeToFit()
        title.textColor = UIColor.secondaryColor
        date.textColor = UIColor.secondaryColor
        overview.textColor = UIColor.secondaryColor
        
        title.numberOfLines = 1
        date.numberOfLines = 1
        overview.numberOfLines = 0
        
        date.adjustsFontSizeToFitWidth = true
        date.lineBreakMode = .byTruncatingTail
        //posterImage.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 749.0), for: .horizontal)
        overview.textAlignment = NSTextAlignment.justified
        overview.adjustsFontSizeToFitWidth = true
        
        title.adjustsFontSizeToFitWidth = true
    }
}
