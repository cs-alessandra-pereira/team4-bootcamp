//
//  FavoritePersistenceServiceSpec.swift
//  Team4BootcampTests
//
//  Created by a.portela.rodrigues on 30/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CoreData
@testable import Team4Bootcamp

class FavoritePersistenceServiceSpec: QuickSpec {
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: PersistenceConstants.persistenceContainerName, managedObjectModel: self.managedObjectModel)
        
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        
        return container
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    override func spec() {
        
        
        func initStubs() {
            let movie1 = Movie(id: 337167, title: "Fifty Shades Freed", releaseDate: Date(timeIntervalSince1970: 0), genres: [Genre(id: 18), Genre(id: 10749)], overview: "Believing they have left behind...", posterPath: "/jjPJ4s3DWZZvI4vw8Xfi4Vqa1Q8.jpg", persisted: false)
            
            let movie2 = Movie(id: 269149, title: "Zootopia", releaseDate: Date(timeIntervalSince1970: 0), genres: [Genre(id: 16), Genre(id: 12), Genre(id: 10751),Genre(id: 35)], overview: "Determined to prove herself...", posterPath: "/sM33SANp9z6rXW8Itn7NnG1GOEs.jpg", persisted: false)
            
            _ = MovieDAO.addMovie(movie: movie1, context: mockPersistantContainer.viewContext)
            _ = MovieDAO.addMovie(movie: movie2, context: mockPersistantContainer.viewContext)
        }
        
        func flushData() {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDAO")
            let objs = try! self.mockPersistantContainer.viewContext.fetch(fetchRequest) //swiftlint:disable:this force_try
            for case let obj as NSManagedObject in objs {
                mockPersistantContainer.viewContext.delete(obj)
            }
            try? mockPersistantContainer.viewContext.save() ///swiftlint:disable:this force_try
        }
        
        describe("FavoritePersistenceService") {
            
            context("Fetching Movies") {
                
                var sut: FavoritePersistenceService!
                var databaseMovies: [Movie] = []
                
                beforeEach {
                    sut = FavoritePersistenceService()
                    initStubs()
                }
                
                afterEach {
                    //flushData()
                }
                
                it("Database should include 2 items") {
                    
                    sut?.fetchMovies(context: self.mockPersistantContainer.viewContext) { result in
                        switch result {
                        case .success(let movies):
                            databaseMovies = movies
                        case .error:
                            databaseMovies = []
                        }
                    }
                    
                    expect(databaseMovies.count).to(equal(2))
                }
            }
        }
    }
}

