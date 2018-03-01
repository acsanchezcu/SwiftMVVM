//
//  MockApiService.swift
//  SwiftMVVMTests
//
//  Created by Sanchez Custodio, Abel on 28/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation
@testable import SwiftMVVM

class MockApiService: APIService {
    
    var completionHandler: CompletionHandler?
    
    // MARK: - Override
    
    override func getDogs(completionHandler: @escaping CompletionHandler) {
        self.completionHandler = completionHandler
    }
    
    override func getDogImage(breed: String, completionHandler: @escaping CompletionHandler) {
        self.completionHandler = completionHandler
    }
    
    override func getBreedImages(breed: String, completionHandler: @escaping CompletionHandler) {
        self.completionHandler = completionHandler
    }
    
    // MARK: - Public methods
    
    func fetchSuccessResponse(_ data: Any) {
        completionHandler?(Response(response: data))
    }
    
    func fetchFailResponse(_ error: CustomError) {
        completionHandler?(Response(error: error))
    }
}
