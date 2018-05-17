//
//  MovieCollectionViewCellStub.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 16/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//
@testable import Team4Bootcamp
import UIKit

final class MovieCollectionViewCellStub: MovieCollectionViewCell {
    override func setup(movie: Movie, at position: IndexPath) {
        textLabel.text = movie.title
        if movie.persisted {
            iconButton.isSelected = true
        } else {
            iconButton.isSelected = false
        }
        imageView.backgroundColor = .red
    }
}
