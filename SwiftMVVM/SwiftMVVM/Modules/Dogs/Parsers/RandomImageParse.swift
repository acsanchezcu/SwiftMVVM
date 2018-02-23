//
//  RandomImageParse.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

class RandomImageParse {
    
    // MARK: - Private
    
    private struct RandomImageCodable: Codable {
        
        // MARK: - Private properties
        
        private let status: String
        private let message: String
        
        // MARK: - Public properties
        
        var imageUrl: String {
            return message
        }
    }
    
    // MARK: - Public methods
    
    func parse(data: Data) -> Response {
        do {
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .iso8601
            
            let response = try JSONDecoder().decode(RandomImageCodable.self, from: data)
            
            return Response(response: response.imageUrl)
        }
        catch {
            return Response(error: error)
        }
    }
    
}
