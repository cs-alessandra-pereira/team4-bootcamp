//
//  FilterViewControllerStub.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 29/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

@testable import Team4Bootcamp

class FilterViewControllerStub: FilterViewController {
   
    var isLoadViewCalled = false
    var isViewDidLoadCalled = false
    var isSetupMoviesCalled = false
    var isSetupGenresCalled = false
    var isExtractYearsFromMoviesCalled = false
    
    override func loadView() {
        isLoadViewCalled = true
        super.loadView()
    }
    
    override func viewDidLoad() {
        isViewDidLoadCalled = true
        super.viewDidLoad()
    }
    
    override func setupMovies(_ movies: [MovieDAO]) {
        isSetupMoviesCalled = true
        super.setupMovies(movies)
    }
    
    override func setupGenres(context: NSManagedObjectContext) {
        isSetupGenresCalled = true
        super.setupGenres(context: context)
    }
}
