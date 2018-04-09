//
//  Extension.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 28/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
//FIXME: Tales - evitem deixar um monte de extensões num unico arquivo - organização do projeto
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        //FIXME: Tales - `precondition` ou `preconditionFailure` são opções melhores: vejam
        // https://www.swiftbysundell.com/posts/picking-the-right-way-of-failing-in-swift
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
    }
    
    static let primaryColor = UIColor(hex: 0xF7CE5B)
    static let secondaryColor = UIColor(hex: 0x2D3047)
    static let terciaryColor = UIColor(hex: 0xD8D8D8)
    static let accentColor = UIColor(hex: 0xD9971E)
    
}

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
