//
//  UserRepository.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

enum ModelResponse <T> {
    case success(result: T)
    case failure //pendiente mensaje
}

typealias ModelCompletion = ( (_ response: ModelResponse<Any>) -> Void )

class UserRepository {
    
    let jsonDecoder = JSONDecoder()
    
    func getUsers (completion: @escaping ModelCompletion) {
        BaseService.shared.sendRequest(endPoint: UserEndpoints.getUsers.rawValue) { (response) in
            switch response {
            case .success(let result):
                do {
                    let users = try self.jsonDecoder.decode([User].self, from: result)
                    completion(.success(result: users))
                } catch let err {
                    print("Error while parsing the data: \(err.localizedDescription)")
                    completion(.failure)
                }
                break
            case .failure:
                completion(.failure)
                break
            case .responseUnsuccessfull(let code):
                print("Unsuccessfull Response -> StatusCode: \(code)")
                break
            }
        }
    }
}
