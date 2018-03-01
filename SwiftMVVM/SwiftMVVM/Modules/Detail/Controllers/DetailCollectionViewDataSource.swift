//
//  DetailCollectionViewDataSource.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var viewModels = [ImageViewModel]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier(), for: indexPath)
        
        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.displayViewModel(viewModels[indexPath.row])
        }
        
        return cell
    }
    
}
