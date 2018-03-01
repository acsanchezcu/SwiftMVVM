//
//  APIService.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 21/02/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import Foundation


typealias CompletionHandler = (Response) -> ()

protocol ServiceProtocol {
    func getDogs(completionHandler: @escaping CompletionHandler)
    func getDogImage(breed: String, completionHandler: @escaping CompletionHandler)
}

class APIService: ServiceProtocol {
    
    // MARK: - Nested
    
    private enum EndPoint: CustomStringConvertible {
        case dogs
        case dogImage(String)
        case breedImages(String)
        
        var description: String {
            switch self {
            case .dogs:
                return "https://dog.ceo/api/breeds/list/all"
            case .dogImage(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .breedImages(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/images"
            }
        }
    }
    
    // MARK: - Properties
    
    let session: URLSession
    
    // MARK: - Init
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - ServiceProtocol
    
    func getDogs(completionHandler: @escaping CompletionHandler) {
        let urlRequest = URLRequest(url: URL(string: EndPoint.dogs.description)!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                completionHandler(DogParse().parse(data: data))
            } else {
                completionHandler(Response(error: error))
            }
            }.resume()
    }
    
    func getDogImage(breed: String, completionHandler: @escaping CompletionHandler) {
        let urlRequest = URLRequest(url: URL(string: EndPoint.dogImage(breed).description)!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                completionHandler(DogImageParse().parse(data: data))
            } else {
                completionHandler(Response(error: error))
            }
            }.resume()
    }
    
    func getBreedImages(breed: String, completionHandler: @escaping CompletionHandler) {
        let urlRequest = URLRequest(url: URL(string: EndPoint.breedImages(breed).description)!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                completionHandler(BreedImagesParse().parse(data: data))
            } else {
                completionHandler(Response(error: error))
            }
            }.resume()
    }
    
}
