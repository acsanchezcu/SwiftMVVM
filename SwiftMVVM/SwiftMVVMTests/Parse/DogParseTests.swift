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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
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
    
}
