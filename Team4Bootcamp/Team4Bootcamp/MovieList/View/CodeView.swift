//
//  CodeView.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 02/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

protocol CodeView {
    func buildHierarchy()
    func buildConstraints()
    func configure()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildHierarchy()
        buildConstraints()
        configure()
    }
    
    func configure() {}
}
