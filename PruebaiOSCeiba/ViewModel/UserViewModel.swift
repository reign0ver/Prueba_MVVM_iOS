//
//  UserViewModel.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/*
 Entity used to send it to the View
 */
struct UserView {
    let userId: Int
    let name: String
    let email: String
    let phoneNumber: String
    
    init(user: User) {
        self.userId = user.userId
        self.name = user.name
        self.email = user.email
        self.phoneNumber = user.phoneNumber
    }
    
    init(userPersistent: UserPersistent) {
        self.userId = Int(userPersistent.userId)
        self.name = userPersistent.name ?? ""
        self.email = userPersistent.email ?? ""
        self.phoneNumber = userPersistent.phoneNumber ?? ""
    }
}

protocol UserViewModelDelegate: class {
    func reloadTable()
}

class UserViewModel {
    
    // MARK: View Messages
    let cellId = "userCell"
    let navigationTitle = "Users"
    let emptyListMessage = "List is empty"
    
    var userView: [UserView] = []
    var userViewFiltered: [UserView] = []
    let repo = UserRepository()
    weak var delegate: UserViewModelDelegate?
    var appDelegate: AppDelegate?
    
    func getUsers () {
        repo.fetchUsersFromApi { (response) in
            switch response {
            case .success(let result):
                let usersResult = result as! [User]
                self.persistData(users: usersResult)
                self.mapUsersIntoUsersView(usersResult: usersResult)
                break
            case .failure:
                break
            }
            self.delegate?.reloadTable()
        }
    }
    
    func persistData (users: [User]) {
        let usersPersist: [UserPersistent] = mapUsersIntoUsersPersist(users: users)
        repo.insertUserIntoLocalDB(userPersistent: usersPersist)
    }
    
    //SRP failed here
    func validateIfData () {
        let usersFromDB = repo.fetchUsersFromLocalDB()
        if usersFromDB.count > 0 {
            mapUsersPersistIntoUsersView(usersPersistence: usersFromDB)
            self.delegate?.reloadTable()
        } else {
            getUsers()
        }
    }
    
    func mapUsersPersistIntoUsersView (usersPersistence: [UserPersistent]) {
        self.userView = usersPersistence.map {
            return UserView(userPersistent: $0)
        }
    }
    
    func mapUsersIntoUsersView (usersResult: [User]) {
        self.userView = usersResult.map {
            return UserView(user: $0)
        }
    }
    
    func mapUsersIntoUsersPersist (users: [User]) -> [UserPersistent] {
        var usersPersist: [UserPersistent] = []
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = appDelegate?.persistentContainer.viewContext {
            let entity = NSEntityDescription.entity(forEntityName: "UserPersistent", in: context)
            usersPersist = users.map { user in
                let userP = UserPersistent(entity: entity!, insertInto: context)
                userP.name = user.name
                userP.email = user.email
                userP.phoneNumber = user.phoneNumber
                return userP
            }
        }
        return usersPersist
    }
    
}
