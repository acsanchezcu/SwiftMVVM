//
//  ImageViewModel.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 28/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

class ImageViewModel {
    
    // MARK: - Properties
    
    let imageUrl: String
    
    // MARK: - Init
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    // MARK: - Class Methods
    
    class func mapper(images: [String]) -> [ImageViewModel] {
        return images.map { ImageViewModel(imageUrl: $0) }
    }
}
