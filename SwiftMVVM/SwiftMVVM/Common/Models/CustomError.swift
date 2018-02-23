//
//  CustomError.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

enum CustomError {
    case custom(String)
    case general
    
    init(_ error: Error?) {
        if let error = error { self = .custom(error.localizedDescription) }
        else {
            self = .general
        }
    }
    
    var description: String {
        switch self {
        case .general:
            return "General error"
        case .custom(let message):
            return "\(message)"
        }
    }
}
