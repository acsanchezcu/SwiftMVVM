//
//  BreedImagesParse.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

class BreedImagesParse {
    
    // MARK: - Private
    
    private struct BreedImagesCodable: Codable {
        
        // MARK: - Private properties
        
        private let status: String
        private let message: [String]
        
        // MARK: - Public properties
        
        var imagesUrl: [String] {
            return message
        }
    }
    
    // MARK: - Public methods
    
    func parse(data: Data) -> Response {
        do {
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .iso8601
            
            let response = try JSONDecoder().decode(BreedImagesCodable.self, from: data)
            
            return Response(response: response.imagesUrl)
        }
        catch {
            return Response(error: error)
        }
    }
    
}
