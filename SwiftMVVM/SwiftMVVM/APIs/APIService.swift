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
    func getRandomImage(breed: String, completionHandler: @escaping CompletionHandler)
}

class APIService: ServiceProtocol {
    
    // MARK: - Nested
    
    private enum EndPoint: CustomStringConvertible {
        case list
        case randomImage(String)
        
        var description: String {
            switch self {
            case .list:
                return "https://dog.ceo/api/breeds/list/all"
            case .randomImage(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
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
        let urlRequest = URLRequest(url: URL(string: EndPoint.list.description)!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                completionHandler(DogParse().parse(data: data))
            } else {
                completionHandler(Response(error: error))
            }
            }.resume()
    }
    
    func getRandomImage(breed: String, completionHandler: @escaping CompletionHandler) {
        let urlRequest = URLRequest(url: URL(string: EndPoint.randomImage(breed).description)!)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                completionHandler(RandomImageParse().parse(data: data))
            } else {
                completionHandler(Response(error: error))
            }
            }.resume()
    }
}
