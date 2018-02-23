//
//  ListViewModel.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 21/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

class DogsViewModel {
    
    // MARK: - Binding
    
    var displayError: ((CustomError) -> ())?
    var displayLoading: ((Bool) -> ())?
    var displayDogs: (([DogViewModel]) -> ())?
    var reloadIndexPathIfNeeded: ((Int) -> ())?
    
    // MARK: - Properties
    
    var service: APIService
    
    var viewModels = [DogViewModel]()
    
    var isLoading = false {
        didSet {
            displayLoading?(isLoading)
        }
    }
    
    var error: CustomError? {
        didSet {
            if let error = error { displayError?(error) }
        }
    }
    
    // MARK: - Init
    
    init(service: APIService = APIService()) {
        self.service = service
    }
    
    // MARK: - Public methods
    
    func fechData() {
        isLoading = true

        service.getDogs { [weak self] (response) in
            self?.isLoading = false
            switch response.status {
            case .failed(let error): break
                self?.error = error
            case .success(let object):
                if let dogs = object as? [Dog] {
                    let viewModels = DogViewModel.mapper(dogs: dogs)
                    self?.viewModels = viewModels
                    self?.displayDogs?(viewModels)
                    self?.fechDogImages()
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    private func fechDogImages() {
        for (index,viewModel) in viewModels.enumerated() {
            var breed = viewModel.breed
            if let subBreed = viewModel.subBreed { breed.append("/\(subBreed)") }
            service.getRandomImage(breed: breed, completionHandler: { [weak self] response in
                switch response.status {
                case .failed(_): break
                case .success(let imageUrl):
                    if let imageUrl = imageUrl as? String,
                        imageUrl != "Breed not found" {
                        self?.viewModels[index].imageUrl = imageUrl
                        self?.reloadIndexPathIfNeeded?(index)
                    }
                }
            })
        }
    }
}
