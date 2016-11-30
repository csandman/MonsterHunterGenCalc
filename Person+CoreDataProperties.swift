//
//  Person+CoreDataProperties.swift
//  MHGenCalc
//
//  Created by Student on 11/29/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var name: String?

}
