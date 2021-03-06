
//
//  AppDelegate.swift
//  MHGenCalc
//
//  Created by Student on 11/17/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var armors = [Armor]()
    var palicoArmors = [PalicoArmor]()
    var builds = [Builds]()
    var displayStrings = [String]()
    var palicoDisplayStrings = [String]()
    var currentSetArr = [Builds]()
    var filterOneArr = [Int]()
    var filterTwoArr = [Int]()
    var filterThreeArr = [Int]()
    var filterFourArr = [Int]()
    var shouldPerformAdvSearch = false
    var slotSelectedForSearch = 10
    var headPassedToSecondView = String()
    var chestPassedToSecondView = String()
    var armsPassedToSecondView = String()
    var waistPassedToSecondView = String()
    var legsPassedToSecondView = String()



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let managedContext = self.managedObjectContext
        
        let initialFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DatabaseLoaded")
        let initialResults = try! managedContext.fetch(initialFetchRequest)
        let initArr = initialResults as! [DatabaseLoaded]
        if (initArr.count == 0) {
            let entity =  NSEntityDescription.entity(forEntityName: "DatabaseLoaded", in:managedContext)
            let isLoaded = DatabaseLoaded(entity: entity!, insertInto: managedContext)
            isLoaded.name = "loaded"
            try! managedContext.save()
            
            let db = self.preloadDb()
            let lines = db.components(separatedBy: "\n")
            for line in lines {
                self.saveArmor(line: line)
            }
            let palicoDb = self.preloadPalicoDb()
            let palicoLines = palicoDb.components(separatedBy: "\n")
            for line in palicoLines {
                self.savePalicoArmor(line: line)
            }
        } else {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let results = try! managedContext.fetch(fetchRequest)
            self.armors = results as! [Armor]
            let palicoFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PalicoArmor")
            let palicoResults = try! managedContext.fetch(palicoFetchRequest)
            self.palicoArmors = palicoResults as! [PalicoArmor]
        }
        
        for armor in palicoArmors {
            print (armor.name! as String)
            print ("")
        }
        for armor in armors {
            print (armor.name! as String)
            print ("")
        }
        
        
        self.createNewSet()
        
        print (currentSetArr[0])
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "UVM.CS" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "MHGenCalc", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("MHGenCalc.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func preloadDb () -> NSString {
        do {
            let fileUrl = Bundle.main.url(forResource: "armorTable", withExtension:"csv")
            let db = try! NSString(contentsOf: fileUrl!, encoding: String.Encoding.utf8.rawValue)
            
            return db
        }
    }
    
    func preloadPalicoDb () -> NSString {
        do {
            let fileUrl = Bundle.main.url(forResource: "PalicoArmor", withExtension:"csv")
            let db = try! NSString(contentsOf: fileUrl!, encoding: String.Encoding.utf8.rawValue)
            
            return db
        }
    }
    
    func saveArmor(line: String)
    {
        let fields = line.components(separatedBy: ",")
        if (fields.count == 13) {
            if (self.lookupArmor(name: fields[11]) == nil) {
                let managedContext = self.managedObjectContext
                
                let entity =  NSEntityDescription.entity(forEntityName: "Armor", in:managedContext)
                let armor = Armor(entity: entity!, insertInto: managedContext)
                
                
                
                armor.name = fields[11]
                armor.id = Int(fields[0]) as NSNumber?
                armor.slot = fields[1]
                armor.defense = Int(fields[2]) as NSNumber?
                armor.max_defense = Int(fields[3]) as NSNumber?
                armor.fire_res = Int(fields[4]) as NSNumber?
                armor.thunder_res = Int(fields[5]) as NSNumber?
                armor.dragon_res = Int(fields[6]) as NSNumber?
                armor.water_res = Int(fields[7]) as NSNumber?
                armor.ice_res = Int(fields[8]) as NSNumber?
                armor.hunter_type = Int(fields[9]) as NSNumber?
                armor.num_slots = Int(fields[10]) as NSNumber?
                armor.rarity = Int(fields[12]) as NSNumber?
                
                do {
                    try managedContext.save()
                    armors.append(armor)
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
                self.displayStrings.append(armor.name!)
                
            } else {
                //print(self.lookupArmor(name: fields[11]))
            }
        }
    }
    
    
    func savePalicoArmor(line: String)
    {
        let fields = line.components(separatedBy: ",")
        
        if (self.lookupPalicoArmor(name: fields[0]) == nil && fields.count == 8) {
            let managedContext = self.managedObjectContext
            
            let entity =  NSEntityDescription.entity(forEntityName: "PalicoArmor", in:managedContext)
            let armor = PalicoArmor(entity: entity!, insertInto: managedContext)
            
            
            
            armor.name = fields[0]
            armor.slot = fields[1]
            armor.defense = Int(fields[2]) as NSNumber?
            armor.fire_res = Int(fields[3]) as NSNumber?
            armor.thunder_res = Int(fields[5]) as NSNumber?
            armor.dragon_res = Int(fields[7]) as NSNumber?
            armor.water_res = Int(fields[4]) as NSNumber?
            armor.ice_res = Int(fields[6]) as NSNumber?
            
            do {
                try managedContext.save()
                palicoArmors.append(armor)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            self.palicoDisplayStrings.append(armor.name!)
            
        } else {
            //print(self.lookupArmor(name: fields[11]))
        }
    }
    
    func lookupArmor(name: String) -> Armor? {
        for a in self.armors {
            if (name == a.name!) { return a }
        }
        return nil
    }
    
    func lookupPalicoArmor(name: String) -> PalicoArmor? {
        for a in self.palicoArmors {
            if (name == a.name!) { return a }
        }
        return nil
    }
    
    func createNewSet() {
        let childContext =
            NSManagedObjectContext(
                concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = self.managedObjectContext
        let currentSet = NSEntityDescription.insertNewObject(forEntityName: "Builds", into: childContext) as! Builds
        currentSet.setName = ""
        currentSet.arms = 0
        currentSet.chest = 0
        currentSet.head = 0
        currentSet.legs = 0
        currentSet.waist = 0
        if (self.currentSetArr.count == 0) {
            self.currentSetArr.append(currentSet)
        } else {
            self.currentSetArr[0] = currentSet
        }
        
        
//        self.currentSetArr[0].setName = ""
//        self.currentSetArr[0].arms = nil
//        self.currentSetArr[0].chest = nil
//        self.currentSetArr[0].head = nil
//        self.currentSetArr[0].legs = nil
//        self.currentSetArr[0].waist = nil
        print(currentSet)
        
        //switch to set page
    }
    
    func loadExistingSet(name: String) -> Builds {
        let buildFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
        let predicate = NSPredicate(format: "%K LIKE %@", "setName", name)
        buildFetch.predicate = predicate
        let fetchedBuilds = try! self.managedObjectContext.fetch(buildFetch) as! [Builds]
        let build = fetchedBuilds[0]
        //        let chestString = String(describing: build.chest! as Int)
        //        let headString = String(describing: build.head! as Int)
        //        let legsString = String(describing: build.legs! as Int)
        //        let armsString = String(describing: build.arms! as Int)
        //        let waistString = String(describing: build.waist! as Int)
        //        self.currentSet = ["setName":build.setName! as String,"head":headString,"chest":chestString,"arms":armsString,"legs":legsString, "waist":waistString]
        print(build)
        self.currentSetArr[0].setName = build.setName
        self.currentSetArr[0].head = build.head
        self.currentSetArr[0].chest = build.chest
        self.currentSetArr[0].arms = build.arms
        self.currentSetArr[0].waist = build.waist
        self.currentSetArr[0].legs = build.legs
        return build
    }
    
    func addArmorPiece(_ armorPiece: Armor) {
        let armorId = armorPiece.id
        let armorType = armorPiece.slot!.lowercased()
        
        switch armorType {
        case "head":
            self.currentSetArr[0].head = armorId
        case "chest":
            self.currentSetArr[0].chest = armorId
        case "arms":
            self.currentSetArr[0].arms = armorId
        case "legs":
            self.currentSetArr[0].legs = armorId
        case "waist":
            self.currentSetArr[0].waist = armorId
        default:
            print("error")
        }
    }
    
    func addArmorPieceById(_ armorId: Int) {
        
        let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let predicate = NSPredicate(format: "%K == %d", "id", armorId)
        armorFetch.predicate = predicate
        let fetchedArmor = try! self.managedObjectContext.fetch(armorFetch) as! [Armor]
        let armor = fetchedArmor[0]
        self.addArmorPiece(armor)
    }
    
    func addArmorPieceByName(_ armorName: String) {
        
        let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let predicate = NSPredicate(format: "%K == %@", "name", armorName)
        armorFetch.predicate = predicate
        let fetchedArmor = try! self.managedObjectContext.fetch(armorFetch) as! [Armor]
        let armor = fetchedArmor[0]
        self.addArmorPiece(armor)
    }
    
    
    func saveSet(name: String) -> Builds {
        let managedContext = self.managedObjectContext
        //let entity =  NSEntityDescription.entity(forEntityName: "Builds", in:managedContext)
        
        var tempSet = self.currentSetArr[0]
        print(tempSet)
        
        if (tempSet.setName == "" || tempSet.setName == nil ) {
            
            //save as new set
            //tempSet.setName = name as NSString
            self.currentSetArr[0].setName = name as NSString?
            do {
                let build = NSEntityDescription.insertNewObject(forEntityName: "Builds", into: managedContext) as! Builds
                build.setName = name as NSString?
                build.head = tempSet.head
                build.chest = tempSet.chest
                build.arms = tempSet.arms
                build.legs = tempSet.legs
                build.waist = tempSet.waist
                try managedContext.save()
                self.builds.append(tempSet)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        } else {
            //check to see if set exists.  if it does, update it, if it does not, save it as new
            do {
                let buildFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
                let predicate = NSPredicate(format: "%K == %@", "setName", tempSet.setName!)
                buildFetch.predicate = predicate
                let fetchedBuilds = try! self.managedObjectContext.fetch(buildFetch) as! [Builds]
                let build = fetchedBuilds[0]
                build.arms = tempSet.arms
                build.chest = tempSet.chest
                build.head = tempSet.head
                build.legs = tempSet.legs
                build.waist = tempSet.waist
                self.currentSetArr[0] = build

                try managedContext.save()
                self.builds.append(build)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        print(tempSet.arms ?? "arms")
        print(tempSet.chest ?? "chest")
        print(tempSet.head ?? "head")
        print(tempSet.legs ?? "legs")
        print(tempSet.waist ?? "waist")
        
        return tempSet
    }
    
    func totalStats(build: Builds) -> Dictionary<String, Int>{
//        let managedContext = self.managedObjectContext
//        let entity =  NSEntityDescription.entity(forEntityName: "Armor", in:managedContext)
//        let dummyArmor = Armor(entity: entity!, insertInto: managedContext)
//        
//        dummyArmor.name = "Dummy Armor"
//        dummyArmor.id = 00000000
//        dummyArmor.defense = 0 as NSNumber?
//        dummyArmor.max_defense = 0 as NSNumber?
//        dummyArmor.fire_res = 0 as NSNumber?
//        dummyArmor.thunder_res = 0 as NSNumber?
//        dummyArmor.dragon_res = 0 as NSNumber?
//        dummyArmor.water_res = 0 as NSNumber?
//        dummyArmor.ice_res = 0 as NSNumber?
        
        //var totalArr = [String: Int]()
        
        var total_defense = 0
        var total_max_defense = 0
        var total_dragon_res = 0
        var total_fire_res = 0
        var total_thunder_res = 0
        var total_ice_res = 0
        var total_water_res = 0
      
        if(build.head != 0){
            let headId = build.head as! Int
            
            let headFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let headPredicate = NSPredicate(format: "%K == %d", "id", headId)
            headFetch.predicate = headPredicate
            var fetchedHead = try! self.managedObjectContext.fetch(headFetch) as! [Armor]
            let head = fetchedHead[0]
            
            total_defense += Int(head.defense!)
            total_max_defense += Int(head.max_defense!)
            total_dragon_res += Int(head.dragon_res!)
            total_fire_res += Int(head.fire_res!)
            total_thunder_res += Int(head.thunder_res!)
            total_ice_res += Int(head.ice_res!)
            total_water_res += Int(head.water_res!)
            
        }
        
        if(build.chest != 0){
            
            let chestId = build.chest as! Int
            
            let chestFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let chestPredicate = NSPredicate(format: "%K == %d", "id", chestId)
            chestFetch.predicate = chestPredicate
            var fetchedChest = try! self.managedObjectContext.fetch(chestFetch) as! [Armor]
            let chest = fetchedChest[0]
            
            total_defense += Int(chest.defense!)
            total_max_defense += Int(chest.max_defense!)
            total_dragon_res += Int(chest.dragon_res!)
            total_fire_res += Int(chest.fire_res!)
            total_thunder_res += Int(chest.thunder_res!)
            total_ice_res += Int(chest.ice_res!)
            total_water_res += Int(chest.water_res!)
        }
        
        if(build.arms != 0){
            
            let armsId = build.arms as! Int
            
            let armsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let armsPredicate = NSPredicate(format: "%K == %d", "id", armsId)
            armsFetch.predicate = armsPredicate
            var fetchedArms = try! self.managedObjectContext.fetch(armsFetch) as! [Armor]
            let arms = fetchedArms[0]
            
            total_defense += Int(arms.defense!)
            total_max_defense += Int(arms.max_defense!)
            total_dragon_res += Int(arms.dragon_res!)
            total_fire_res += Int(arms.fire_res!)
            total_thunder_res += Int(arms.thunder_res!)
            total_ice_res += Int(arms.ice_res!)
            total_water_res += Int(arms.water_res!)
        }
        
        if(build.legs != 0){
            
            let legsId = build.legs as! Int
            
            let legsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let legsPredicate = NSPredicate(format: "%K == %d", "id", legsId)
            legsFetch.predicate = legsPredicate
            var fetchedLegs = try! self.managedObjectContext.fetch(legsFetch) as! [Armor]
            let legs = fetchedLegs[0]
            
            total_defense += Int(legs.defense!)
            total_max_defense += Int(legs.max_defense!)
            total_dragon_res += Int(legs.dragon_res!)
            total_fire_res += Int(legs.fire_res!)
            total_thunder_res += Int(legs.thunder_res!)
            total_ice_res += Int(legs.ice_res!)
            total_water_res += Int(legs.water_res!)
        }
        
        if(build.waist != 0){
            
            let waistId = build.waist as! Int
            
            let waistFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let waistPredicate = NSPredicate(format: "%K == %d", "id", waistId)
            waistFetch.predicate = waistPredicate
            var fetchedWaist = try! self.managedObjectContext.fetch(waistFetch) as! [Armor]
            let waist = fetchedWaist[0]
            
            total_defense += Int(waist.defense!)
            total_max_defense += Int(waist.max_defense!)
            total_dragon_res += Int(waist.dragon_res!)
            total_fire_res += Int(waist.fire_res!)
            total_thunder_res += Int(waist.thunder_res!)
            total_ice_res += Int(waist.ice_res!)
            total_water_res += Int(waist.water_res!)
            
        }
       /* if((build.head != nil) && (build.chest != nil) && (build.arms != nil) && (build.legs != nil) && (build.waist != nil)){
        let headId = build.head as! Int
        let chestId = build.chest as! Int
        let legsId = build.legs as! Int
        let armsId = build.arms as! Int
        let waistId = build.waist as! Int
        
        
        let headFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let headPredicate = NSPredicate(format: "%K == %d", "id", headId)
        headFetch.predicate = headPredicate
        var fetchedHead = try! self.managedObjectContext.fetch(headFetch) as! [Armor]
        let head = fetchedHead[0]
        
        let chestFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let chestPredicate = NSPredicate(format: "%K == %d", "id", chestId)
        chestFetch.predicate = chestPredicate
        var fetchedChest = try! self.managedObjectContext.fetch(chestFetch) as! [Armor]
        let chest = fetchedChest[0]
        
        let armsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let armsPredicate = NSPredicate(format: "%K == %d", "id", armsId)
        armsFetch.predicate = armsPredicate
        var fetchedArms = try! self.managedObjectContext.fetch(armsFetch) as! [Armor]
        let arms = fetchedArms[0]
        
        let legsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let legsPredicate = NSPredicate(format: "%K == %d", "id", legsId)
        legsFetch.predicate = legsPredicate
        var fetchedLegs = try! self.managedObjectContext.fetch(legsFetch) as! [Armor]
        let legs = fetchedLegs[0]
        
        let waistFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let waistPredicate = NSPredicate(format: "%K == %d", "id", waistId)
        waistFetch.predicate = waistPredicate
        var fetchedWaist = try! self.managedObjectContext.fetch(waistFetch) as! [Armor]
        let waist = fetchedWaist[0]
        
        
        let total_defense = Int(head.defense!) + Int(chest.defense!) + Int(arms.defense!) + Int(legs.defense!) + Int(waist.defense!)
        let total_max_defense = Int(head.max_defense!) + Int(chest.max_defense!) + Int(arms.max_defense!) + Int(legs.max_defense!) + Int(waist.max_defense!)
        let total_dragon_res = Int(head.dragon_res!) + Int(chest.dragon_res!) + Int(arms.dragon_res!) + Int(legs.dragon_res!) + Int(waist.dragon_res!)
        let total_ice_res = Int(head.ice_res!) + Int(chest.ice_res!) + Int(arms.ice_res!) + Int(legs.ice_res!) + Int(waist.ice_res!)
        let total_fire_res = Int(head.fire_res!) + Int(chest.fire_res!) + Int(arms.fire_res!) + Int(legs.fire_res!) + Int(waist.fire_res!)
        let total_thunder_res = Int(head.thunder_res!) + Int(chest.thunder_res!) + Int(arms.thunder_res!) + Int(legs.thunder_res!) + Int(waist.thunder_res!)
        let total_water_res = Int(head.water_res!) + Int(chest.water_res!) + Int(arms.water_res!) + Int(legs.water_res!) + Int(waist.water_res!)
       let totalArr = ["defense":total_defense,"max_defense":total_max_defense,"dragon_res":total_dragon_res,"ice_res":total_ice_res,"fire_res":total_fire_res,"thunder_res":total_thunder_res,"water_res":total_water_res]
        }
        */
        
        let totalArr = ["defense":total_defense,"max_defense":total_max_defense,"dragon_res":total_dragon_res,"ice_res":total_ice_res,"fire_res":total_fire_res,"thunder_res":total_thunder_res,"water_res":total_water_res]
        return(totalArr)
        
    }
    func outputString() -> String {
        let set = self.currentSetArr[0]
        var setString = "mhgc-"
        if (set.head != nil) {
            let armorInt = set.head as! Int
            setString += String(armorInt)+"-"
        } else {
            setString += "0-"
        }
        if (set.chest != nil) {
            let armorInt = set.chest as! Int
            setString += String(armorInt)+"-"
        } else {
            setString += "0-"
        }
        if (set.arms != nil) {
            let armorInt = set.arms as! Int
            setString += String(armorInt)+"-"
        } else {
            setString += "0-"
        }
        if (set.waist != nil) {
            let armorInt = set.waist as! Int
            setString += String(armorInt)+"-"
        } else {
            setString += "0-"
        }
        if (set.legs != nil) {
            let armorInt = set.legs as! Int
            setString += String(armorInt)
        } else {
            setString += "0"
        }
        print(setString)
        return setString
    }
    func parseOutputString(setString: String) -> Builds {
        print(setString)
        let setFields = setString.components(separatedBy: "-")
        let headCode = Int(setFields[1])
        let chestCode = Int(setFields[2])
        let armsCode = Int(setFields[3])
        let waistCode = Int(setFields[4])
        let legsCode = Int(setFields[5])
        if (headCode == 0) {
            self.currentSetArr[0].head = 0
        } else {
            self.currentSetArr[0].head = (headCode! as NSNumber)
        }
        if (chestCode == 0) {
            self.currentSetArr[0].chest = 0
        } else {
            self.currentSetArr[0].chest = (chestCode! as NSNumber)
        }
        if (armsCode == 0) {
            self.currentSetArr[0].arms = 0
        } else {
            self.currentSetArr[0].arms = (armsCode! as NSNumber)
        }
        if (waistCode == 0) {
            self.currentSetArr[0].waist = 0
        } else {
            self.currentSetArr[0].waist = (waistCode! as NSNumber)
        }
        if (legsCode == 0) {
            self.currentSetArr[0].legs = 0
        } else {
            self.currentSetArr[0].legs = (legsCode! as NSNumber)
        }
        
        self.currentSetArr[0].setName = ""
        print(self.currentSetArr[0])
        return self.currentSetArr[0]
    }
    
}

