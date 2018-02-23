//
//  DogViewModel.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

class DogViewModel {
    
    // MARK: - Properties
    
    let breed: String
    let subBreed: String?
    var imageUrl: String?
    
    // MARK: - Init
    
    init(breed: String, subBreed: String? = nil, imageUrl: String? = nil) {
        self.breed = breed
        self.subBreed = subBreed
        self.imageUrl = imageUrl
    }
    
    // MARK: - Class Methods
    
    class func mapper(dogs: [Dog]) -> [DogViewModel] {
        return dogs.sorted { ($0.breed, $0.subBreed ?? "") < ($1.breed, $1.subBreed ?? "") }.map {
            DogViewModel(breed: $0.breed, subBreed: $0.subBreed, imageUrl: $0.imageUrl)
        }
    }
}
