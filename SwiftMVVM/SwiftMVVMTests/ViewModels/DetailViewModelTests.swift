//
//  DetailViewModelTests.swift
//  SwiftMVVMTests
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import XCTest
@testable import SwiftMVVM

class DetailViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: DetailViewModel!
    var mockApiService: MockApiService!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        
        mockApiService = MockApiService()
        viewModel = DetailViewModel(service: mockApiService, breed: "someBreed")
    }
    
    override func tearDown() {
        mockApiService = nil
        viewModel = nil
        
        super.tearDown()
    }
    
    // MARK: - Private Methods
    
    private func fetchImages() -> [String] {
        return [0...10].map { "image \($0)" }
    }
    
    // MARK: - Tests
    
    func testLoadingFetch() {
        var isLoading = false
        
        let expect = XCTestExpectation(description: "elements received")
        
        viewModel.displayLoading = { loading in
            isLoading = loading
            expect.fulfill()
        }
        
        viewModel.fetchBreedImages()
        
        XCTAssertTrue(isLoading)
        
        mockApiService.fetchSuccessResponse([])
        
        XCTAssertFalse(isLoading)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testFailFetchImages() {
        let defaultError = CustomError.general
        
        let expect = XCTestExpectation(description: "fail request")
        
        viewModel.displayError = { error in
            XCTAssertEqual(defaultError.description, error.description)
            expect.fulfill()
        }
        
        viewModel.fetchBreedImages()
        
        mockApiService.fetchFailResponse(defaultError)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func testSuccessFetchImages() {
        let expect = XCTestExpectation(description: "success request")
        
        let images = fetchImages()
        
        viewModel.displayImages = { viewModels in
            expect.fulfill()
            XCTAssertEqual(images.count, viewModels.count)
        }
        
        viewModel.fetchBreedImages()
        
        mockApiService.fetchSuccessResponse(images)
        
        wait(for: [expect], timeout: 1.0)
    }
}
