//
//  UserViewModel.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

struct UserViewModel {
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
