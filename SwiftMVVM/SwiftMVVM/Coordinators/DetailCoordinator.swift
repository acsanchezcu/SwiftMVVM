//
//  DetailCoordinator.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    private let breed: String
    
    // MARK: - Init
    
    init(presenter: UINavigationController, breed: String) {
        self.presenter = presenter
        self.breed = breed
    }
    
    // MARK: - Coordinator
    
    func start() {
        let viewModel = DetailViewModel(breed: breed)
        let viewController = DetailViewController(viewModel: viewModel)
        viewController.title = breed
        presenter.pushViewController(viewController, animated: true)
    }
    
}
