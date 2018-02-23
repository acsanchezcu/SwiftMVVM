//
//  DogParse.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

class DogParse {
    
    // MARK: - Private
    
    private struct DogsCodable: Codable {
        
        // MARK: - Private properties
        
        private let status: String
        private let message: [String: [String]]
        
        // MARK: - Public properties
        
        var dogs: [Dog] {
            var dogs: [Dog] = []
            
            for dog in message {
                if dog.value.isEmpty {
                    dogs.append(Dog(breed: dog.key, subBreed: nil, imageUrl: nil))
                } else {
                    dog.value.forEach { dogs.append(Dog(breed: dog.key, subBreed: $0, imageUrl: nil)) }
                }
            }
            
            return dogs
        }
    }
    
    // MARK: - Public methods
    
    func parse(data: Data) -> Response {
        do {
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .iso8601
            
            let response = try JSONDecoder().decode(DogsCodable.self, from: data)
            
            return Response(response: response.dogs)
        }
        catch {
            return Response(error: error)
        }
    }
    
}
