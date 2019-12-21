//
//  PostViewModel.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

struct PostView {
    let title: String
    let text: String
    
    init(post: Post) {
        self.title = post.title
        self.text = post.body
    }
    
}

protocol PostViewModelDelegate {
    func reloadTable()
}

class PostViewModel {
    
    let cellId = "postCell"
    var userView: UserView?
    var postView: [PostView] = []
    var delegate: PostViewModelDelegate?
    
    func getPostsByUser () {
        PostRepository().getPostsById(userId: userView!.userId, completion: { (response) in
            switch response {
            case .success(let result):
                let postsResult = result as! [Post]
                self.mapPostsIntoPostsView(postsResult: postsResult)
                break
            case .failure:
                break
            }
            self.delegate?.reloadTable()
        })
    }
    
    func mapPostsIntoPostsView (postsResult: [Post]) {
        self.postView = postsResult.map {
            return PostView(post: $0)
        }
    }
    
}

