//
//  FavoriteButton.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 03/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

extension UIButton {
    static func favoriteButton(target: Any?, withSelector selector: Selector) -> UIButton {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(icon: .favGray), for: UIControlState.normal)
        button.setImage(UIImage(icon: .favFull), for: UIControlState.selected)
        button.contentMode = UIViewContentMode.scaleAspectFit
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
}
