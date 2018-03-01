//
//  String+Extension.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 01/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func contains(string: String) -> Bool {
        return uppercased().contains(string.uppercased())
    }
}
