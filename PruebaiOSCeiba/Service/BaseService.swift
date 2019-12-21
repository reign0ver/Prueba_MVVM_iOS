//
//  BaseService.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

enum ServiceResponse {
    case success(response: Data)
    case failure
    case responseUnsuccessfull(code: Int)
}

typealias RequestCompletion = ( (_ response: ServiceResponse) -> Void )

class BaseService {
    
    func sendRequest (endPoint: String, completion: @escaping RequestCompletion) {
        let session = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        guard let url = URL(string: AppConstants.baseUrl + endPoint) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Failed to fetch users: ", error.localizedDescription)
                completion(.failure)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let data = data {
                        completion(.success(response: data))
                    } else {
                        completion(.responseUnsuccessfull(code: response.statusCode))
                    }
                }
            }
        }
        dataTask?.resume()
    }
    
    func sendRequest2 (endPoint: String, completion: @escaping RequestCompletion) {
        
    }
    
}
