//
//  UserViewModel.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

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
}

protocol UserViewModelDelegate: class {
    func reloadTable()
}

class UserViewModel {
    
    let cellId = "userCell"
    let navigationTitle = "Users"
    let emptyListMessage = "List is empty"
    
    var userView: [UserView] = []
    var userViewFiltered: [UserView] = []
    let repo = UserRepository()
    weak var delegate: UserViewModelDelegate?
    
    func getUsers () {
        repo.getUsers { (response) in
            switch response {
            case .success(let result):
                let usersResult = result as! [User]
                self.mapUsersIntoUsersView(usersResult: usersResult)
                break
            case .failure:
                break
            }
            self.delegate?.reloadTable()
        }
    }
    
    func mapUsersIntoUsersView (usersResult: [User]) {
        self.userView = usersResult.map {
            return UserView(user: $0)
        }
    }
    
}
