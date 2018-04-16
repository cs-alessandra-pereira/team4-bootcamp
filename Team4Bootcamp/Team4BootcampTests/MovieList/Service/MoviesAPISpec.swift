//
//  MoviesAPISpec.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 06/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

@testable import Team4Bootcamp
import Quick
import Nimble


class MoviesAPISpec: QuickSpec {
    
    override func spec() {
    
        describe("MoviesAPI") {
        
            context("request has returned") {
                
                let sut = MoviesAPIStub()
                
                it("should correctly parse genrewrapper json") {
                    sut.request(endpoint: .genre) { _ in expect(sut.genreWasParsed).to(beTrue()) }
                }
                
                it("should correctly parse Movie") {
                    sut.request(endpoint: .movieList) { _ in expect(sut.movieWasParsed).to(beTrue()) }
                }
            }
        }
    }
}
