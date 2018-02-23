//
//  DogsTableViewDataSource.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel (Cognizant) on 23/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class DogsTableViewDataSource: NSObject, UITableViewDataSource {
    var dogs = [DogViewModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if let dogsCell = cell as? DogTableViewCell {
            dogsCell.displayViewModel(dogs[indexPath.row])
        }
        
        return cell
    }
    
}
