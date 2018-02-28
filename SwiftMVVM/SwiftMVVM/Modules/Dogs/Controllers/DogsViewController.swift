//
//  DogsViewController.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 21/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DogsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = dataSource
//            tableView.delegate = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 90.0
            let nib = UINib(nibName: String(describing: DogTableViewCell.self), bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "reuseIdentifier")
        }
    }
    // MARK: - Properties
    
    private var viewModel: DogsViewModel
    private let dataSource = DogsTableViewDataSource()
    
    // MARK: - Init
    
    init(viewModel: DogsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: DogsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        manageViewModel()
    }
    
    // MARK: - Private Methods
    
    private func manageViewModel() {
        viewModel.displayDogs = { [weak self] dogs in
            DispatchQueue.main.async {
                self?.dataSource.dogs = dogs
                self?.tableView.reloadData()
            }
            
            // Fetch image for each dog
            dogs.forEach { self?.viewModel.fetchDogImage($0)}
        }
        
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
        
        viewModel.reloadDogViewModel = { [weak self] dogViewModel in
            if let index = self?.dataSource.dogs.index(where: {$0 === dogViewModel}) {
                DispatchQueue.main.async {
                    self?.reloadIndexPathIfNeeded(Int(index))
                }
            }
        }
        
        viewModel.fetchData()
    }
    
    private func reloadIndexPathIfNeeded(_ index: Int) {
        guard let indexPaths = tableView.indexPathsForVisibleRows else { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        
        if indexPaths.contains(indexPath) {
            print("reload indexPath \(indexPath.row)")
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }

    private func displayLoading(_ loading: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        
        if loading {
            // display loading
            
        } else {
            // hide loading
        }
    }
    
    private func displayError(_ error: CustomError) {
        // localized text
        let alertController = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
