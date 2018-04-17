//
//  FavoritePersistenceService.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 16/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit

protocol MoviePersistenceProtocol: MoviesProtocol {
    func deleteMovie()
}

final class FavoritePersistenceService: MoviePersistenceProtocol{
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func deleteMovie() {
        <#code#>
    }
    
    func fetchMovies(callback: @escaping ([Movie]) -> Void) {
        <#code#>
    }
    
    func fetchGenres(callback: @escaping ([GenreId : GenreName]) -> Void) {
        <#code#>
    }
    
}
