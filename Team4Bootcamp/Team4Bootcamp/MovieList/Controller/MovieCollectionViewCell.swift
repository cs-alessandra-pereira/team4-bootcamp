//
//  MovieCollectionViewCell.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 02/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var textLabel: UILabel!
    var imageView: UIImageView!
    var iconImgView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                              width: frame.size.width, height: frame.size.height*2/3))
        imageView.contentMode = UIViewContentMode.scaleToFill
        contentView.addSubview(imageView)
        
        textLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height,
                                          width: frame.size.width/3, height: frame.size.height/3))
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        
        iconImgView = UIImageView(frame: CGRect(x: imageView.frame.width*4/5, y: imageView.frame.size.height,
                                                width: frame.size.width/5, height: textLabel.frame.size.height))
        
        iconImgView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(iconImgView)
        
        iconImgView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: iconImgView,
                                         attribute: NSLayoutAttribute.centerY,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: textLabel,
                                         attribute: NSLayoutAttribute.centerY,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: iconImgView,
                                         attribute: NSLayoutAttribute.rightMargin,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: contentView,
                                         attribute: NSLayoutAttribute.rightMargin,
                                         multiplier: 1,
                                         constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

