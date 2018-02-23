//
//  DogViewModelTests.swift
//  SwiftMVVMTests
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import XCTest
@testable import SwiftMVVM

class DogViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Verify that sort and map correctly
    
    func testMapper() {
        let dogs = [Dog(breed: "hound", subBreed: "blood", imageUrl: nil),
                    Dog(breed: "hound", subBreed: "walker", imageUrl: nil),
                    Dog(breed: "hound", subBreed: "afghan", imageUrl: nil),
                    Dog(breed: "affenpinscher", subBreed: nil, imageUrl: nil)]
        let viewModels = DogViewModel.mapper(dogs: dogs)
        
        XCTAssertEqual(viewModels.count, dogs.count)
        
        XCTAssertEqual(viewModels[0].breed, "affenpinscher")
        XCTAssertEqual(viewModels[1].subBreed, "afghan")
        XCTAssertEqual(viewModels[2].subBreed, "blood")
        XCTAssertEqual(viewModels[3].subBreed, "walker")
    }
    
}
