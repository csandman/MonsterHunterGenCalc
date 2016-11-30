//
//  Shoes+CoreDataProperties.swift
//  CS
//
//  Created by Christian Skalka on 10/12/16.
//  Copyright © 2016 Christian Skalka. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Shoes {

    @NSManaged var style: String?
    @NSManaged var owner: Person?

}
