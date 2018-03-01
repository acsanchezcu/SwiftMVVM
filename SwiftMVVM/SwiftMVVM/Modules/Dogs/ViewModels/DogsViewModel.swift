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
    var displayDogs: (([DogViewModel], Bool) -> ())?
    var reloadDogViewModel: ((DogViewModel) -> ())?
    var navigateToDetail: ((UIViewController) -> ())?
    
    // MARK: - Properties
    
    private var service: APIService
    private var coordinator: DogsCoordinator
    
    private var viewModels = [DogViewModel]()
    private var searchViewModels: [DogViewModel] {
        if let search = search,
            !search.isEmpty {
            return viewModels.filter({ (viewModel) -> Bool in
                if viewModel.breed.contains(string: search) { return true }
                if let subBreed = viewModel.subBreed,
                    subBreed.contains(string: search) { return true }
                return false
            })
        } else {
            return viewModels
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
    
    private var search: String? {
        didSet {
            displayDogs?(searchViewModels, false)
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
                    self?.displayDogs?(viewModels, true)
                }
            }
        }
    }

    func fetchDogImage(_ viewModel: DogViewModel) {
        let breedNotFound = "Breed not found"
        var breed = viewModel.breed
        if let subBreed = viewModel.subBreed { breed.append("/\(subBreed)") }
        service.getDogImage(breed: breed, completionHandler: { [weak self] response in
            switch response.status {
            case .failed(_): break
            case .success(let imageUrl):
                if let imageUrl = imageUrl as? String,
                    imageUrl != breedNotFound {
                    viewModel.imageUrl = imageUrl
                    self?.reloadDogViewModel?(viewModel)
                }
            }
        })
    }
    
    func didSearch(search: String?) {
        self.search = search
    }

    func didSelectRowAt(indexPath: IndexPath) {
        let breed = searchViewModels[indexPath.row].breed
        
        coordinator.navigateToDetail(breed: breed)
    }
}
