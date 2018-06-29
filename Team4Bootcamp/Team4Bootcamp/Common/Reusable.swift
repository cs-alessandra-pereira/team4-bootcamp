//
//  Reusable.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 11/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable: class {
    static var defaultReuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {
    
}
