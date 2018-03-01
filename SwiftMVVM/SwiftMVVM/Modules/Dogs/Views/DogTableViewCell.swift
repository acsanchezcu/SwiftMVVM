//
//  DogTableViewCell.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

protocol DogTableViewCellProtocol {
    func displayViewModel(_ viewModel: DogViewModel)
}

class DogTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var subBreedLabel: UILabel!
    @IBOutlet weak var breedImageView: UIImageView! {
        didSet {
            breedImageView.layer.masksToBounds = true
            breedImageView.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .phone ? 25 : 37.5
        }
    }
    
    // MARK: - Class methods
    
    class func reuseIdentifier() -> String {
        return "reuseIdentifier"
    }
}

extension DogTableViewCell: DogTableViewCellProtocol {
    
    func displayViewModel(_ viewModel: DogViewModel) {
        breedLabel?.text = viewModel.breed
        subBreedLabel?.text = viewModel.subBreed
        
        if let imageUrl = viewModel.imageUrl {
            breedImageView?.loadImageUrl(imageUrl)
        } else {
            breedImageView?.image = #imageLiteral(resourceName: "dog")
        }
    }
    
}
