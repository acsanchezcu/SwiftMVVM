//
//  DetailViewModel.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 28/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    // MARK: - Binding
    
    var displayError: ((CustomError) -> ())?
    var displayLoading: ((Bool) -> ())?
    var displayImages: (([ImageViewModel]) -> ())?
    
    // MARK: - Properties
    
    private var service: APIService
    private var breed: String
    
    private var viewModels = [ImageViewModel]() {
        didSet {
            displayImages?(viewModels)
        }
    }
    
    private var isLoading = false {
        didSet {
            displayLoading?(isLoading)
        }
    }
    
    private var error: CustomError? {
        didSet {
            if let error = error { displayError?(error) }
        }
    }

    // MARK: - Init
    
    init(service: APIService = APIService(), breed: String) {
        self.service = service
        self.breed = breed
    }

    func fetchBreedImages() {
        isLoading = true
        
        service.getBreedImages(breed: breed) { [weak self] (response) in
            self?.isLoading = false
            switch response.status {
            case .failed(let error):
                self?.error = error
            case .success(let object):
                if let images = object as? [String] {
                    let viewModels = ImageViewModel.mapper(images: images)
                    self?.viewModels = viewModels
                }
            }
        }
    }
}
