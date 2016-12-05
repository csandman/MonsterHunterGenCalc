//
//  ThirdViewController.swift
//  MHGenCalc
//
//  Created by Student on 11/30/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import CoreData

let RESET = false

class ThirdViewController: UIViewController, UITableViewDataSource{
    
    var displayStrings = [String]()
    var people = [Person]()
    var armors = [Armor]()
    @IBOutlet weak var tableView: UITableView!
    @IBAction func SearchFunc(sender: AnyObject) {
        let alert = UIAlertController(title: "Find Armor",
                                      message: "Search for an Armor Piece",
                                      preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Search",
                                         style: .default,
                                         handler: { (action:UIAlertAction) -> Void in
                                            let appDelegate =
                                                UIApplication.shared.delegate as! AppDelegate
                                            let moc = appDelegate.managedObjectContext
                                            let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                                            
                                      
                                            let name = alert.textFields![0].text
//                                            print(name!)
                                            
                                            if (name != "") {
                                                let predicate = NSPredicate(format: "%K CONTAINS[c] %@", "name", name!)
                                                armorFetch.predicate = predicate
                                            }
                                            
                                            do {
                                                let fetchedArmor = try moc.fetch(armorFetch) as! [Armor]
                                                self.displayStrings.removeAll()
                                                for armor in fetchedArmor {
                                                    self.displayStrings.append(armor.name! + " has " + String(describing: armor.defense!) + " defense")
                                                    self.tableView.reloadData()
                                                }
//                                                print(fetchedArmor)
                                            } catch {
                                                fatalError("Failed to fetch armor: \(error)")
                                            }
                                            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default,
                                         handler: { (action: UIAlertAction) -> Void in })
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        
        present(alert,
                animated: true,
                completion: nil)
        
        
        
    }

    
//    func saveArmor(line: String) -> Armor
//     {
//     let appDelegate =
//     UIApplication.shared.delegate as! AppDelegate
//     
//     let managedContext = appDelegate.managedObjectContext
//     
//     let entity =  NSEntityDescription.entity(forEntityName: "Armor", in:managedContext)
//     let armor = Armor(entity: entity!, insertInto: managedContext)
//     
//        let fields = line.components(separatedBy: ",")
//     
//     armor.name = fields[11]
//     armor.id = Int(fields[0]) as NSNumber?
//     armor.slot = fields[1]
//     armor.defense = Int(fields[2]) as NSNumber?
//     armor.max_defense = Int(fields[3]) as NSNumber?
//     armor.fire_res = Int(fields[4]) as NSNumber?
//     armor.thunder_res = Int(fields[5]) as NSNumber?
//     armor.dragon_res = Int(fields[6]) as NSNumber?
//     armor.water_res = Int(fields[7]) as NSNumber?
//     armor.ice_res = Int(fields[8]) as NSNumber?
//     armor.hunter_type = Int(fields[9]) as NSNumber?
//     armor.num_slots = Int(fields[10]) as NSNumber?
//     armor.rarity = Int(fields[12]) as NSNumber?
//     
//     
//     do {
//     try managedContext.save()
//     armors.append(armor)
//     } catch let error as NSError  {
////     print("Could not save \(error), \(error.userInfo)")
//     }
//     self.displayStrings.append(armor.name! + " has " + String(describing: armor.ice_res!) + " ice resistance")
//     return armor
//     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
  
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
//        let appDelegate =
//            UIApplication.shared.delegate as! AppDelegate
//        
//        let db = appDelegate.preloadDb()
//        let lines = db.components(separatedBy: "\n")
//        for line in lines {
//            self.saveArmor(line: line)
//            self.tableView.reloadData()
        
            
            //            if (fields[0] != "") {
            //                let nameField = String(fields[2])
            //                var p = self.lookupName(nameField)
            //
            //                if (p == nil)
            //                {
            //                    p = self.saveName(nameField)
            //                }
            //
            //                let shoeField = String(fields[1])
            //                self.saveShoes(p!, style: shoeField)
            //
            //
            
            //            }
            
            
//        }
        
        /*let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            people = results as! [Person]
            
            if (RESET)
            {
                for p in people
                {
                    for s in p.wardrobe!
                    {
                        managedContext.delete(s as! Shoes)
                    }
                    managedContext.delete(p)
                }
                try managedContext.save()
            }
            else
            {
                for p in people
                {
                    people.append(p)
                    
                    for s in p.wardrobe!
                    {
                        let shoes = s as! Shoes
                        self.displayStrings.append(p.name! + " owns " + shoes.style!)
                    }
                }
                self.tableView.reloadData()
                
            }
        } catch let error as NSError {
            print("fetch or save failed \(error), \(error.userInfo)")
        }*/
        
    }
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return displayStrings.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell!.textLabel!.text = displayStrings[indexPath.row]
        
        return cell!
    }
}
