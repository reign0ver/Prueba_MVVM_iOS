//
//  UserPersistent+CoreDataProperties.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 21/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//
//

import Foundation
import CoreData


extension UserPersistent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPersistent> {
        return NSFetchRequest<UserPersistent>(entityName: "UserPersistent")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var userId: String?

}
