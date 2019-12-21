//
//  PostRepository.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

class PostRepository {
    
    let networkProvider = BaseService()
    
    func getPostsById (userId: Int, completion: @escaping ModelCompletion) {
        let endpoint = PostEndpoints.getPostsById.rawValue + "\(userId)"
        
        networkProvider.sendRequest(endPoint: endpoint) { (response) in
            switch response {
            case .success(let result):
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: result)
                    completion(.success(result: posts))
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
