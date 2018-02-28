//
//  ImageCache.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

/// Class to cache the url images

class ImageCache {
    
    // MARK: - Singleton
    
    static var shared = ImageCache()
    
    // MARK: - Properties
    
    var cache = NSCache<AnyObject, AnyObject>()
}
