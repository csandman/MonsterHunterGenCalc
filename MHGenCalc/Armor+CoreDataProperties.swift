//
//  Armor+CoreDataProperties.swift
//  CS
//
//  Created by Scott Sandvik on 11/25/16.
//  Copyright © 2016 Christian Skalka. All rights reserved.
//

import Foundation
import CoreData

extension Armor {
    
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var slot: String?
    @NSManaged var defense: NSNumber?
    @NSManaged var max_defense: NSNumber?
    @NSManaged var fire_res: NSNumber?
    @NSManaged var thunder_res: NSNumber?
    @NSManaged var dragon_res: NSNumber?
    @NSManaged var water_res: NSNumber?
    @NSManaged var ice_res: NSNumber?
    @NSManaged var hunter_type: NSNumber?
    @NSManaged var num_slots: NSNumber?
    @NSManaged var rarity: NSNumber?
    
}
