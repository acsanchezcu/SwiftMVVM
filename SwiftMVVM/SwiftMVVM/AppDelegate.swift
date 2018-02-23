//
//  AppDelegate.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 21/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // ListViewController as root
        let viewController = Coordinator.listViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

