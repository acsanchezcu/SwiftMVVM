//
//  ListViewModel.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 21/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DogsViewModel {
    
    // MARK: - Binding
    
    var displayError: ((CustomError) -> ())?
    var displayLoading: ((Bool) -> ())?
    var displayDogs: (([DogViewModel]) -> ())?
    var reloadDogViewModel: ((DogViewModel) -> ())?
    var navigateToDetail: ((UIViewController) -> ())?
    
    // MARK: - Properties
    
    private var service: APIService
    private var coordinator: DogsCoordinator
    
    private var viewModels = [DogViewModel]()
    
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
    
    init(service: APIService = APIService(), coordinator: DogsCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    // MARK: - Public methods
    
    func fetchData() {
        isLoading = true

        service.getDogs { [weak self] (response) in
            self?.isLoading = false
            switch response.status {
            case .failed(let error):
                self?.error = error
            case .success(let object):
                if let dogs = object as? [Dog] {
                    let viewModels = DogViewModel.mapper(dogs: dogs)
                    self?.viewModels = viewModels
                    self?.displayDogs?(viewModels)
                }
            }
        }
    }

    func fetchDogImage(_ viewModel: DogViewModel) {
        var breed = viewModel.breed
        if let subBreed = viewModel.subBreed { breed.append("/\(subBreed)") }
        service.getDogImage(breed: breed, completionHandler: { [weak self] response in
            switch response.status {
            case .failed(_): break
            case .success(let imageUrl):
                if let imageUrl = imageUrl as? String,
                    imageUrl != "Breed not found" {
                    viewModel.imageUrl = imageUrl
                    self?.reloadDogViewModel?(viewModel)
                }
            }
        })
    }

    func didSelectRowAt(indexPath: IndexPath) {
        let breed = viewModels[indexPath.row].breed
        
        coordinator.navigateToDetail(breed: breed)
    }
}
