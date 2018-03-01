//
//  BreedParseTests.swift
//  SwiftMVVMTests
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import XCTest
@testable import SwiftMVVM

class BreedParseTests: XCTestCase {
    
    // MARK: - Tests
    
    func testFailParse() {
        guard let data = "".data(using: .utf8) else {
            XCTFail("Wrong data built")
            return
        }
        
        let response = BreedImagesParse().parse(data: data)
        
        switch response.status {
        case .failed(let error):
            XCTAssertNotNil(error)
        default:
            XCTFail("response fails")
        }
    }
    
    func testSuccessParse() {
        guard let data = """
        {"status":"success","message":["imageUrl1","imageUrl2"]}
        """.data(using: .utf8) else {
            XCTFail("Wrong data built")
            return
        }
        
        let response = BreedImagesParse().parse(data: data)
        
        switch response.status {
        case .success(let images):
            guard let images = images as? [String] else {
                XCTFail("wrong data")
                return
            }
            XCTAssertEqual(images.count, 2)
            XCTAssertEqual(images.first, "imageUrl1")
        default:
            XCTFail("response fails")
        }
    }
    
}
