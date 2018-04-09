//
//  FetchResult.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 29/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
//FIXME: Tales - muito bom criar esse tipo. Só renomearia apenas para `Result`, assim pode ser usado com qualquer
// resultado q ou contenha um valor ou contenha um erro, e não apenas para fetch (por exemplo, um étodo que salva
// um dado num banco, ou o upload de um arq, ou um POST na API
enum FetchResult <T, E: Error> {
    case success(T)
    case error(E)
}
