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
    var displayStrings = [String]()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let managedContext = self.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let results = try! managedContext.fetch(fetchRequest)
        self.armors = results as! [Armor]
        
        let db = self.preloadDb()
        let lines = db.components(separatedBy: "\n")
        for line in lines {
            _ = self.saveArmor(line: line)
        }
        for armor in armors {
            print (armor.name)
        }
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
        
        // name of the database file, with newline-separated records
        let dbfile = "ArmorFile.csv"
        // record field delimeter (is a comma for csv)
        let delimeter = ","
        
        /*
         process_fields takes as input an array of strings which are the raw field
         values for a given record. If one wants to save the field values in
         persistent memory, this is where the Core Data logic should go.
         
         Note that if field values need to be interpreted as non-String datatypes,
         e.g. as numeric or boolean values, explicit type conversion needs to be
         performed here as well.
         */
        func process_fields(fields : [NSString])
        {
            
            let f0 = fields[0]
            if (f0 != "") {
//                print((fields[0] as String)+","+(fields[1] as String)+","+(fields[2] as String))
            }
        }
        
        /*
         import_db processes the input database file-- it iterates through each line,
         splits the line into delimeter-separated fields, and applies process_fields to
         the fields.
         */
        func import_db() -> NSString
        {
            do
            {
                let fileUrl = Bundle.main.url(forResource: "armorTable", withExtension:"csv")
                let db = try NSString(contentsOf: fileUrl!, encoding: String.Encoding.utf8.rawValue)
                
                return db
                //                let lines = db.componentsSeparatedByString("\n")
                //
                //                return lines
                //                for line in lines
                //                {
                //                    let fields = line.componentsSeparatedByString(delimeter)
                //                    process_fields(fields)
                //                }
            }
            catch let error as NSError
            {
                print("file \(dbfile) input failed \(error), \(error.userInfo)")
            }
            return NSString()
        }
        
        return import_db()
    }
    func saveArmor(line: String) -> Armor
    {
        let managedContext = self.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Armor", in:managedContext)
        let armor = Armor(entity: entity!, insertInto: managedContext)
        
        let fields = line.components(separatedBy: ",")
        
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
        
        if (lookupArmor(name: armor.name!) == nil) {
            do {
                try managedContext.save()
                armors.append(armor)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
        
        self.displayStrings.append(armor.name!)
        return armor
    }
    func lookupArmor(name: String) -> Armor? {
        for a in armors {
            if (name == a.name) { return a }
        }
        return nil
    }

}

