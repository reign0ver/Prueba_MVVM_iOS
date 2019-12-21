//
//  BaseService.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceResponse {
    case success(response: Data)
    case failure
    case responseUnsuccessfull(code: Int)
}

typealias RequestCompletion = ( (_ response: ServiceResponse) -> Void )

class BaseService {
    
    func sendRequest (endPoint: String, completion: @escaping RequestCompletion) {
        let url = AppConstants.baseUrl + endPoint
        
        AF.request(url, method: .get).response { (response) in
            if let error = response.error {
                print("Failed to fetch users: ", error.localizedDescription)
                completion(.failure)
                return
            }
            
            if let response = response.response {
                if response.statusCode != 200 {
                    completion(.responseUnsuccessfull(code: response.statusCode))
                }
            }
            
            if let data = response.data {
                completion(.success(response: data))
            }
        }
    }
    
}
