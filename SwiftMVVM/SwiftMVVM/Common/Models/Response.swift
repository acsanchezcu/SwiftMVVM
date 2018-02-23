//
//  Response.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

class Response {
    
    // MARK: - Properties
    
    var status: Status
    
    // MARK: - Init methods
    
    init(error: Error?) {
        let error = CustomError(error)
        self.status = Response.Status.failed(error)
    }
    
    init(error: CustomError) {
        self.status = Status.failed(error)
    }
    
    init(response: Any) {
        self.status = Status.success(response)
    }
}

extension Response {
    enum Status {
        case failed(CustomError)
        case success(Any)
    }
}
