//
//  DogsCoordinator.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DogsCoordinator: Coordinator {

    // MARK: - Properties
    
    let presenter: UINavigationController
    var detailCoordinator: DetailCoordinator?
    
    // MARK: - Init
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // MARK: - Public methods
    
    func navigateToDetail(breed: String) {
        detailCoordinator = DetailCoordinator(presenter: presenter, breed: breed)
        detailCoordinator?.start()
    }
    
    // MARK: - Coordinator
    
    func start() {
        let viewModel = DogsViewModel(coordinator: self)
        let viewController = DogsViewController(viewModel: viewModel)
        presenter.pushViewController(viewController, animated: false)
    }
    
}
