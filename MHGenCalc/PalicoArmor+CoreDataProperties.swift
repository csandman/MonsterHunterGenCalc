//
//  PalicoArmor+CoreDataProperties.swift
//  MHGenCalc
//
//  Created by Student on 12/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import CoreData

extension PalicoArmor {
    
    @NSManaged var name: String?
    @NSManaged var slot: String?
    @NSManaged var defense: NSNumber?
    @NSManaged var fire_res: NSNumber?
    @NSManaged var thunder_res: NSNumber?
    @NSManaged var dragon_res: NSNumber?
    @NSManaged var water_res: NSNumber?
    @NSManaged var ice_res: NSNumber?

}
