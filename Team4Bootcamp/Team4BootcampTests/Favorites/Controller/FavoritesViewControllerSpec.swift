//
//  FavoritesViewControllerSpec.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 26/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import Quick
import Nimble

class FavoritesViewControllerSpec: QuickSpec {
    override func spec() {
        describe("FavoritesViewController") {
            context("When FavoritesViewController is being initialized") {
                
                var sut: FavoritesViewControllerStub!
                
                beforeEach {
                    sut = FavoritesViewControllerStub.init(nibName: nil, bundle: nil)
                    sut.beginAppearanceTransition(true, animated: false)
                    sut.endAppearanceTransition()
                }
                
                it("should call setupDelegate") {
                    expect(sut.setupDelegateWasCalled).to(beTrue())
                }
                it("should call setupDataSouce") {
                    expect(sut.setupDataSourceWasCalled).to(beTrue())
                }
                it("should call setupSearchBar") {
                    expect(sut.setupSearchBarWasCalled).to(beTrue())
                }
            }
        }
    }
}
