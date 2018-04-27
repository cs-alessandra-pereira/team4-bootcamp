//
//  FavoriteButton.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 03/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(UIImage(icon: .favGray), for: UIControlState.normal)
        self.setImage(UIImage(icon: .favFull), for: UIControlState.selected)
        self.contentMode = UIViewContentMode.scaleAspectFit
    }
    
}
