//
//  UIImage+Extension.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

protocol ImageViewProtocol {
    func loadImageUrl(_ urlString: String)
}

extension UIImageView: ImageViewProtocol {

    var cache: NSCache<AnyObject, AnyObject> {
        return NSCache<AnyObject, AnyObject>()
    }
    
    func loadImageUrl(_ urlString: String) {
        if let image = ImageCache.shared.cache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = image
            return
        }
        
        image = #imageLiteral(resourceName: "dog")
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data,
                let image = UIImage(data: data) {
                
                ImageCache.shared.cache.setObject(image, forKey: urlString as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = image
                }
                
            }
            }.resume()
    }
    
}
