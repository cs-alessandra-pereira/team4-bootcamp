//
//  FetchResult.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

enum Result <T, E: Error> {
    case success(T)
    case error(E)
}
