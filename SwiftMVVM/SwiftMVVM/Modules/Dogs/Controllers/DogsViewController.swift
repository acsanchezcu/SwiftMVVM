//
//  DogsViewController.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 21/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DogsViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = dataSource
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 90.0
            tableView.keyboardDismissMode = .onDrag
            let nib = UINib(nibName: String(describing: DogTableViewCell.self), bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: DogTableViewCell.reuseIdentifier())
            tableView.tableFooterView = UIView()
        }
    }
    // MARK: - Properties
    
    private var viewModel: DogsViewModel
    private let dataSource = DogsTableViewDataSource()
    
    // Navigation bar items
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)

        searchBar.placeholder = "dogs_placeholder".localized
        searchBar.delegate = self
        searchBar.isHidden = true
        
        return searchBar
    }()
    
    lazy var rightBarButtomItem: UIBarButtonItem = {
        let barButtomItem = UIBarButtonItem(title: "dogs_search".localized, style: .done, target: self, action: #selector(rightBarButtomItemTapped))
        return barButtomItem
    }()
    
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
        
        title = "dogs_title".localized
        
        navigationItem.rightBarButtonItem = rightBarButtomItem
    }
    
    // MARK: - Actions
    
    @objc func rightBarButtomItemTapped() {
        searchBar.isHidden = !searchBar.isHidden
        
        if searchBar.isHidden {
            navigationItem.titleView = nil
            rightBarButtomItem.title = "dogs_search".localized
            searchBar.resignFirstResponder()
        } else {
            navigationItem.titleView = searchBar
            rightBarButtomItem.title = "dogs_cancel".localized
            searchBar.becomeFirstResponder()
        }
        
        searchBar.text = nil
        viewModel.didSearch(search: nil)
    }
    
    // MARK: - Private Methods
    
    private func manageViewModel() {
        viewModel.displayDogs = { [weak self] dogs, fetchImages in
            DispatchQueue.main.async {
                self?.dataSource.dogs = dogs
                self?.tableView.reloadData()
            }
            
            if fetchImages {
                // Fetch image for each dog
                dogs.forEach { self?.viewModel.fetchDogImage($0)}
            }
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
            if let index = self?.dataSource.dogs.firstIndex(where: {$0 === dogViewModel}) {
                DispatchQueue.main.async {
                    self?.reloadIndexPathIfNeeded(Int(index))
                }
            }
        }
        
        viewModel.navigateToDetail = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
        viewModel.fetchData()
    }
    
    private func reloadIndexPathIfNeeded(_ index: Int) {
        guard let indexPaths = tableView.indexPathsForVisibleRows else { return }
        
        let indexPath = IndexPath(row: index, section: 0)
        
        if indexPaths.contains(indexPath) {
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }

    private func displayLoading(_ loading: Bool) {
        if loading {
            showLoading()
        } else {
            dismissLoading()
        }
    }
    
    private func displayError(_ error: CustomError) {
        displayAlert(withTitle: "error_title".description, message: error.description)
    }
}

extension DogsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
    
}

extension DogsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didSearch(search: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
