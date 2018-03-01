//
//  DogParse.swift
//  SwiftMVVMTests
//
//  Created by Sanchez Custodio, Abel on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import XCTest
@testable import SwiftMVVM

class DogParseTests: XCTestCase {
    
    // MARK: - Tests
    
    func testFailParse() {
        guard let data = "".data(using: .utf8) else {
            XCTFail("Wrong data built")
            return
        }
        
        let response = DogParse().parse(data: data)
        
        switch response.status {
        case .failed(let error):
            XCTAssertNotNil(error)
        default:
            XCTFail("response fails")
        }
    }
    
    func testSuccessParseBreed() {
        guard let data = """
        {"status":"success","message":{"affenpinscher":[]}}
        """.data(using: .utf8) else {
            XCTFail("Wrong data built")
            return
        }
        
        let response = DogParse().parse(data: data)
        
        switch response.status {
        case .success(let dogs):
            guard let dogs = dogs as? [Dog] else {
                XCTFail("wrong data")
                return
            }
            XCTAssertEqual(dogs.count, 1)
            XCTAssertEqual(dogs.first?.breed, "affenpinscher")
        default:
            XCTFail("response fails")
        }
    }
    
    func testSuccessParseSubbreed() {
        guard let data = """
        {"status":"success","message":{"hound":["Ibizan","afghan","basset","blood","english","walker"]}}
        """.data(using: .utf8) else {
            XCTFail("Wrong data built")
            return
        }
        
        let response = DogParse().parse(data: data)
        
        switch response.status {
        case .success(let dogs):
            guard let dogs = dogs as? [Dog] else {
                XCTFail("wrong data")
                return
            }
            XCTAssertEqual(dogs.count, 6)
            XCTAssertEqual(dogs.first?.breed, "hound")
            XCTAssertEqual(dogs.first?.subBreed, "Ibizan")
        default:
            XCTFail("response fails")
        }
    }
    
    func testFailParseDogImages() {
        guard let data = "".data(using: .utf8) else {
            XCTFail("Wrong data built")
            return
        }
        
        let response = DogImageParse().parse(data: data)
        
        switch response.status {
        case .failed(let error):
            XCTAssertNotNil(error)
        default:
            XCTFail("response fails")
        }
    }
    
    func testSuccessParseDogImages() {
        guard let data = """
        {"status":"success","message":"imageUrl"}
        """.data(using: .utf8) else {
            XCTFail("Wrong data built")
            return
        }
        
        let response = DogImageParse().parse(data: data)
        
        switch response.status {
        case .success(let imageUrl):
            guard let imageUrl = imageUrl as? String else {
                XCTFail("wrong data")
                return
            }
            XCTAssertEqual(imageUrl, "imageUrl")
        default:
            XCTFail("response fails")
        }
    }
    
}
