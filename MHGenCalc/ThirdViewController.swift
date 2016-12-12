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
                                                let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
                                                let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
                                                let sortDescriptors = [sortDescriptor1,sortDescriptor2]
                                                armorFetch.sortDescriptors = sortDescriptors
                                                let predicate = NSPredicate(format: "%K CONTAINS[c] %@", "name", name!)
                                                armorFetch.predicate = predicate
                                            }
                                            
                                            do {
                                                let fetchedArmor = try moc.fetch(armorFetch) as! [Armor]
                                                self.displayStrings.removeAll()
                                                for armor in fetchedArmor {
                                                    self.displayStrings.append(armor.name! as String!)
                                                    //print(armor.name! as String)
                                                }
                                                self.tableView.reloadData()
                                                
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        
        do {
            let results = try! managedContext.fetch(fetchRequest)
            armors = results as! [Armor]
            self.displayStrings.removeAll()
            for armor in armors {
                self.displayStrings.append(armor.name! as String)
            }
        }
        self.tableView.reloadData()
        
//        appDelegate.addArmorPieceById(1311031)
//        appDelegate.addArmorPieceById(1376337)
//        appDelegate.addArmorPieceById(1441869)
//        appDelegate.addArmorPieceById(1507453)
//        appDelegate.addArmorPieceById(1572902)
        //print(appDelegate.currentSetArr[0])
        //print(appDelegate.saveSet())
        //let set = appDelegate.loadExistingSet(name: "test1")
        //print(set.legs!)
        //print(set.arms!)
        //appDelegate.totalStats(build: set)
        
        
        
    }
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return displayStrings.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSearch")
        cell!.textLabel!.textColor=UIColor.white; //changes the text color for a cell
        cell!.textLabel!.text = displayStrings[indexPath.row]
        
        
    
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let name = displayStrings[indexPath.row]
        do {
            let results = try! managedContext.fetch(fetchRequest)
            armors = results as! [Armor]
        
            var imageArmor : UIImage
            for armor in armors {
                if(name == armor.name){
                    if(armor.slot == "Chest"){
                   
                         imageArmor = UIImage(named: "chest")!
                        cell?.imageView?.image = imageArmor
                    }
                    if(armor.slot == "Arms"){
                     
                        imageArmor = UIImage(named: "arms")!
                        cell?.imageView?.image = imageArmor
                    }
                    if(armor.slot == "Legs"){
                        
                        imageArmor = UIImage(named: "leg")!
                        cell?.imageView?.image = imageArmor
                    }
                    if(armor.slot == "Waist"){
                        
                        imageArmor = UIImage(named: "wait")!
                        cell?.imageView?.image = imageArmor
                    }
                    if(armor.slot == "Head"){
                        
                        imageArmor = UIImage(named: "Helm")!
                        cell?.imageView?.image = imageArmor
                    }
                }
                
            }
        }
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            
            /*let selectedIndex = sender as! NSIndexPath
             let currentCell =  savedTable.cellForRow(at: selectedIndex as IndexPath)! as UITableViewCell
             self.valueToPass = currentCell.textLabel!.text!*/
            
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let controller = segue.destination as! ArmorResultViewController
                controller.armorValue = displayStrings[indexPath.row]
                let appDelegate =
                    UIApplication.shared.delegate as! AppDelegate
                //_ = appDelegate.loadExistingSet(name: controller.passedValue!)
            }
            
        }
    }
}
