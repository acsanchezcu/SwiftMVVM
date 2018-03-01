//
//  ImageCollectionViewCell.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

protocol ImageCollectionViewCellProtocol {
    func displayViewModel(_ viewModel: ImageViewModel)
}

class ImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Class methods
    
    class func reuseIdentifier() -> String {
        return "reuseIdentifier"
    }
}

extension ImageCollectionViewCell: ImageCollectionViewCellProtocol {
    
    func displayViewModel(_ viewModel: ImageViewModel) {
        imageView.loadImageUrl(viewModel.imageUrl)
    }
    
}
