//
//  FilterViewControllerSpec.swift
//  Team4BootcampTests
//
//  Created by alessandra.l.pereira on 29/05/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Quick
import Nimble
import CoreData

@testable import Team4Bootcamp

class FilterViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FilterViewController") {
            context("When FilterViewController is being initialized") {
                
                var sut: FilterViewControllerStub!
                
                beforeEach {
                    sut = FilterViewControllerStub.init(nibName: nil, bundle: nil)
                    sut.beginAppearanceTransition(true, animated: false)
                    sut.endAppearanceTransition()
                    
                }
                it("has everything you need to get started (describes the expected result of the test)") {

                    
                    expect(sut.isLoadViewCalled).to(beTrue())
                    expect(sut.isViewDidLoadCalled).to(beTrue())
                    
                    expect(sut.isSetupMoviesCalled).to(beFalse())
                    sut.setupMovies([])
                    expect(sut.isSetupMoviesCalled).to(beTrue())
                    
                    expect(sut.isSetupGenresCalled).to(beFalse())
                    if let ctx = FavoritesViewController.container?.viewContext {
                        sut.setupGenres(context: ctx)
                    }
                    expect(sut.isSetupGenresCalled).to(beTrue())
                }
                
            }
        }
    }
}
