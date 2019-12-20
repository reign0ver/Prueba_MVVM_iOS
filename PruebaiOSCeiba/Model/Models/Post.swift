//
//  Post.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

//MARK: PostEntity
struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    private enum CodingKeys: CodingKey {
        case userId
        case id
        case title
        case body
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.userId   = try container.decode(Int.self, forKey: .userId)
        self.id       = try container.decode(Int.self, forKey: .id)
        self.title    = try container.decode(String.self, forKey: .title)
        self.body     = try container.decode(String.self, forKey: .body)
    }
}
