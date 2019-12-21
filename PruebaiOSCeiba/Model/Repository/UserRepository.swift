//
//  UserRepository.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import UIKit
import Foundation
import CoreData

enum ModelResponse <T> {
    case success(result: T)
    case failure
}

typealias ModelCompletion = ( (_ response: ModelResponse<Any>) -> Void )

class UserRepository {
    
    let networkProvider = BaseService()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func fetchUsersFromApi (completion: @escaping ModelCompletion) {
        networkProvider.sendRequest(endPoint: UserEndpoints.getUsers.rawValue) { (response) in
            switch response {
            case .success(let result):
                do {
                    let users = try JSONDecoder().decode([User].self, from: result)
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
    
    //Pendiente por closure
    func fetchUsersFromLocalDB () -> [UserPersistent] {
        
        if let context = appDelegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<UserPersistent>(entityName: "UserPersistent")
            
            do {
                return try context.fetch(request)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return []
    }
    
    func insertUserIntoLocalDB (userPersistent: [UserPersistent]) {
        if let context = appDelegate?.persistentContainer.viewContext {
            
            for userP in userPersistent {
                let user: UserPersistent = NSEntityDescription.insertNewObject(forEntityName: "UserPersistent", into: context) as! UserPersistent
                user.name = userP.name
                user.email = userP.email
                user.phoneNumber = userP.phoneNumber
                do {
                    try context.save()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
