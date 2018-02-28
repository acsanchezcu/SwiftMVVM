//
//  Coordinator.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 21/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

struct Coordinator {
    
    static func listViewController(viewModel: DogsViewModel = DogsViewModel()) -> UIViewController {
        let viewController = DogsViewController(viewModel: viewModel)
        return viewController
    }
    
    func detailViewController(viewModel: DetailViewModel) -> UIViewController {
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }
    
}
