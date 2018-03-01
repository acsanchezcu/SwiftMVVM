//
//  DetailViewController.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 28/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = dataSource
            collectionView.delegate = self
            let nib = UINib(nibName: String(describing: ImageCollectionViewCell.self), bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier())
        }
    }
    
    // MARK: - Properties
    
    private var viewModel: DetailViewModel
    private let dataSource = DetailCollectionViewDataSource()
    
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
        viewModel.displayLoading = { [weak self] loading in
            DispatchQueue.main.async {
                self?.displayLoading(loading)
            }
        }
        
        viewModel.displayError = { [weak self] error in
            DispatchQueue.main.async {
                self?.displayError(error)
            }
        }
        
        viewModel.displayImages = { [weak self] viewModels in
            DispatchQueue.main.async {
                self?.dataSource.viewModels = viewModels
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.fetchBreedImages()
    }
    
    private func displayLoading(_ loading: Bool) {
        if loading {
            showLoading()
        } else {
            dismissLoading()
        }
    }
    
    private func displayError(_ error: CustomError) {
        displayAlert(withTitle: "error_title".localized, message: error.description)
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
    }
    
}
