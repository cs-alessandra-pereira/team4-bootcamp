//
//  Extension.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 28/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//
import UIKit

extension UIImage {
    enum Icons: String {
        case favFull = "favorite_full_icon"
        case favEmpty = "favorite_empty_icon"
        case favGray = "favorite_gray_icon"
        case check = "check_icon"
        case filter = "FilterIcon"
        case list = "list_icon"
        case search = "search_icon"
    }
    
    convenience init?(icon: Icons) {
        self.init(named: icon.rawValue)
    }
}
