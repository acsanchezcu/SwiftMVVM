//
//  AppCoordinator.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    // MARK: - Properties
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let dogsCoordinator: DogsCoordinator
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
        
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = true
        
        dogsCoordinator = DogsCoordinator(presenter: rootViewController)
        dogsCoordinator.start()
    }
    
    // MARK: - Coordinator
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
