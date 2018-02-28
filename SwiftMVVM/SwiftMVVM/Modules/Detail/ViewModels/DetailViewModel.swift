//
//  DetailViewModel.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel  on 28/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation

class DetailViewModel {
    
    // MARK: - Properties
    
    private var service: APIService
    private var coordinator: Coordinator
    var breed: String
    
    // MARK: - Init
    
    init(service: APIService = APIService(), coordinator: Coordinator = Coordinator(), breed: String) {
        self.service = service
        self.coordinator = coordinator
        self.breed = breed
    }

}
