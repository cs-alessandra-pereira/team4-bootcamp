//
//  Connection.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 13/06/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

protocol Connectable {
    var endpoint: Endpoint { get }
    func makeRequest(handler: @escaping (Result<Data, MoviesError>) -> Void)
}

extension Connectable {
    func makeRequest(handler: @escaping (Result<Data, MoviesError>) -> Void) {
        URLSession.shared.dataTask(with: endpoint.request()) { data, response, error in
            switch (data, error) {
            case(let data?, _): handler(.success(data))
            default: handler(.error(MoviesError.noConection))
            }
        }.resume()
    }
}

struct Connection: Connectable {
    var endpoint: Endpoint
}
