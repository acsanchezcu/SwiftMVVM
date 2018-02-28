//
//  LoadingView.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 28/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    // MARK: - UI properties
    
    private let blackBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = .black
        return activityIndicator
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupUILayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupUILayout() {
        addSubview(blackBackgroundView)
        
        blackBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blackBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blackBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blackBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
