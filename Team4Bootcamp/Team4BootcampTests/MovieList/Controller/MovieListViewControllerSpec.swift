//
//  MovieListViewControllerSpec.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 11/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

@testable import Team4Bootcamp
import Quick
import Nimble

class MovieListViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("MovieListViewController") {
            
            context("viewDidLoad was called") {
                
                let sut = MovieListViewControllerStub()
                sut.beginAppearanceTransition(true, animated: false)
                sut.endAppearanceTransition()
                
                it("should call setupDelegates") {
                    expect(sut.setupDelegatesWasCalled).to(beTrue())
                }
                
                it("should call setupDatasources") {
                    expect(sut.setupDatasourceWasCalled).to(beTrue())
                }
                
                it("should call fetchGenres") {
                    expect(sut.fetchGenresWasCalled).to(beTrue())
                }
                
                it("should call fetchMovies") {
                    expect(sut.fetchMoviesWasCalled).to(beTrue())
                }
                
            }
        }
    }
}
