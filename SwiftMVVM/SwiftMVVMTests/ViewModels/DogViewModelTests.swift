//
//  DogViewModelTests.swift
//  SwiftMVVMTests
//
//  Created by Sanchez Custodio, Abel on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import XCTest
@testable import SwiftMVVM

class DogViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: DogsViewModel!
    var mockApiService: MockApiService!
    
    override func setUp() {
        super.setUp()

        mockApiService = MockApiService()
        viewModel = DogsViewModel(service: mockApiService)
    }
    
    override func tearDown() {
        mockApiService = nil
        viewModel = nil
        
        super.tearDown()
    }
    
    // MARK: - Private methods
    
    private func fetchDogs() -> [Dog] {
        return [Dog(breed: "hound", subBreed: "blood", imageUrl: nil),
                Dog(breed: "hound", subBreed: "walker", imageUrl: nil),
                Dog(breed: "hound", subBreed: "afghan", imageUrl: nil),
                Dog(breed: "affenpinscher", subBreed: nil, imageUrl: nil)]
    }
    
    /// Verify that sort and map correctly
    
    func testMapper() {
        let dogs = fetchDogs()
        let viewModels = DogViewModel.mapper(dogs: dogs)
        
        XCTAssertEqual(viewModels.count, dogs.count)
        
        XCTAssertEqual(viewModels[0].breed, "affenpinscher")
        XCTAssertEqual(viewModels[1].subBreed, "afghan")
        XCTAssertEqual(viewModels[2].subBreed, "blood")
        XCTAssertEqual(viewModels[3].subBreed, "walker")
    }
    
    func testLoadingFetch() {
        var isLoading = false
    
        let expect = XCTestExpectation(description: "elements received")
        
        viewModel.displayLoading = { loading in
            isLoading = loading
            expect.fulfill()
        }
        
        viewModel.fetchData()
        
        XCTAssertTrue(isLoading)
        
        mockApiService.fetchSuccessResponse([])
        
        XCTAssertFalse(isLoading)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testFailFetchDogs() {
        let defaultError = CustomError.general
        
        let expect = XCTestExpectation(description: "fail request")
        
        viewModel.displayError = { error in
            XCTAssertEqual(defaultError.description, error.description)
            expect.fulfill()
        }
        
        viewModel.fetchData()
        
        mockApiService.fetchFailResponse(defaultError)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testSuccessFetchDogs() {
        let expect = XCTestExpectation(description: "success request")
        
        let dogs = fetchDogs()

        viewModel.displayDogs = { viewModels in
            expect.fulfill()
            XCTAssertEqual(dogs.count, viewModels.count)
        }
        
        viewModel.fetchData()
        
        mockApiService.fetchSuccessResponse(dogs)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testSuccessFetchDogImage() {
        let dogs = fetchDogs()
        
        let dogsViewModel = DogViewModel.mapper(dogs: dogs)
        
        for (index, dogViewModel) in dogsViewModel.enumerated() {
            let expect = XCTestExpectation(description: "success image request")
            let imageUrl = "Image number \(index)"
            
            viewModel.reloadDogViewModel = { dogViewModel in
                expect.fulfill()
                XCTAssertEqual(dogViewModel.imageUrl, imageUrl)
            }
            
            viewModel.fetchDogImage(dogViewModel)
            
            mockApiService.fetchSuccessResponse(imageUrl)
            
            wait(for: [expect], timeout: 1.0)
        }
    }
    
}
