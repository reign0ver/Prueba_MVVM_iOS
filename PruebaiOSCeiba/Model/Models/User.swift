//
//  User.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import Foundation

/*
 This file contains the UserEntity
 and all the entities associated to it
 */

// MARK: UserEntity
struct User: Decodable {
    let userId: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phoneNumber: String
    let website: String
    let company: Company
    
    private enum CodingKeys: CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        
        self.userId      = try container.decode(Int.self, forKey: .id)
        self.name        = try container.decode(String.self, forKey: .name)
        self.username    = try container.decode(String.self, forKey: .username)
        self.email       = try container.decode(String.self, forKey: .email)
        self.address     = try container.decode(Address.self, forKey: .address)
        self.phoneNumber = try container.decode(String.self, forKey: .phone)
        self.website     = try container.decode(String.self, forKey: .website)
        self.company     = try container.decode(Company.self, forKey: .company)
    }
}

//MARK: AddressEntity
struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipCode: String
    let geolocalization: Coordinates
    
    private enum CodingKeys: CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
    
    init(from decoder: Decoder) throws {
        let container        = try decoder.container(keyedBy: CodingKeys.self)
        
        self.street          = try container.decode(String.self, forKey: .street)
        self.suite           = try container.decode(String.self, forKey: .suite)
        self.city            = try container.decode(String.self, forKey: .city)
        self.zipCode         = try container.decode(String.self, forKey: .zipcode)
        self.geolocalization = try container.decode(Coordinates.self, forKey: .geo)
    }
}

//MARK: Geo Entity
struct Coordinates: Decodable {
    let latitude: String
    let longitude: String
    
    private enum CodingKeys: CodingKey {
        case lat
        case lng
    }
    
    init(from decoder: Decoder) throws {
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        
        self.latitude  = try container.decode(String.self, forKey: .lat)
        self.longitude = try container.decode(String.self, forKey: .lng)
    }
}

//MARK: CompanyEntity
struct Company: Decodable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    private enum CodingKeys: CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    init(from decoder: Decoder) throws {
        let container    = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name        = try container.decode(String.self, forKey: .name)
        self.catchPhrase = try container.decode(String.self, forKey: .catchPhrase)
        self.bs          = try container.decode(String.self, forKey: .bs)
    }
}
