//
//  BaseViewController.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 28/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    var loadingView: LoadingView?
    
    // MARK: - Public methods
    
    func showLoading() {
        let mainView: UIView!
        
        if let view = navigationController?.view {
            mainView = view
        } else {
            mainView = view
        }
        
        loadingView = LoadingView()
        
        mainView.addSubview(loadingView!)
        
        loadingView?.translatesAutoresizingMaskIntoConstraints = false
        loadingView?.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        loadingView?.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        loadingView?.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        loadingView?.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
    }
    
    func dismissLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    func displayAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok_button".localized, style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
