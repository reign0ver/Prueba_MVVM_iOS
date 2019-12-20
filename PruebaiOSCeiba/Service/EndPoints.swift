//
//  EndPoints.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

enum UserEndpoints: String {
    case getUsers = "/users"
}

enum PostEndpoints: String {
    case getPosts = "/posts"
    case getPostsById = "/posts?userId="
}
