//
//  DetailViewController.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel  on 28/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var viewModel: DetailViewModel
    
    // MARK: - Init
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manageViewModel()
    }
    
    // MARK: - Private methods
    
    private func manageViewModel() {
        // link binding stuffs
        title = viewModel.breed
    }
}
