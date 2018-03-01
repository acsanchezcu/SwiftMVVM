//
//  AppDelegate.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 21/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        
        appCoordinator = AppCoordinator(window: window)
        
        self.window = window
        
        appCoordinator?.start()
        
        return true
    }

}

