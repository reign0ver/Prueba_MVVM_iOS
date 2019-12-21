//
//  PostViewModel.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

struct PostViewModel {
    let title: String
    let text: String
//    let user: User
    
    init(post: Post) {
        self.title = post.title
        self.text = post.body
    }
    
}
