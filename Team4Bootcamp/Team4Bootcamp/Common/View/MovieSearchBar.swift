//
//  MovieSearchBar.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 13/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.primaryColor?.cgColor
        if let textField = self.value(forKey: "_searchField") as? UITextField {
            textField.backgroundColor = UIColor.accentColor
        }
    }
}
