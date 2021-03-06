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
    var palArmors = [PalicoArmor]()

    @IBAction func advSearchClick(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let arrayToPass = Array(repeating: 0, count: 5)
        let arrayToPass2 = Array(repeating: 0, count: 5)
        let arrayToPass3 = Array(repeating: 0, count: 2)
        let arrayToPass4 = [1,100]
        
        appDelegate.filterOneArr = arrayToPass
        appDelegate.filterTwoArr = arrayToPass2
        appDelegate.filterThreeArr = arrayToPass3
        appDelegate.filterFourArr = arrayToPass4
        
        
        print(arrayToPass4)
    }
    
    
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
                                            let palicoFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PalicoArmor")
                                      
                                            let name = alert.textFields![0].text
//                                            print(name!)
                                            
                                            
                                            var armorPredicates = [NSPredicate]()
                                            
                                            if (appDelegate.slotSelectedForSearch == 0) {
                                                armorPredicates.append(NSPredicate(format: "%K LIKE %@", "slot", "Head"))
                                            } else if (appDelegate.slotSelectedForSearch == 1) {
                                                armorPredicates.append(NSPredicate(format: "%K LIKE %@", "slot", "Chest"))
                                            } else if (appDelegate.slotSelectedForSearch == 2) {
                                                armorPredicates.append(NSPredicate(format: "%K LIKE %@", "slot", "Arms"))
                                            } else if (appDelegate.slotSelectedForSearch == 3) {
                                                armorPredicates.append(NSPredicate(format: "%K LIKE %@", "slot", "Waist"))
                                            } else if (appDelegate.slotSelectedForSearch == 4) {
                                                armorPredicates.append(NSPredicate(format: "%K LIKE %@", "slot", "Legs"))
                                            }
                                            
                                            
                                            if (name != "") {
                                                
                                                let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
                                                let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
                                                let sortDescriptors = [sortDescriptor1,sortDescriptor2]
                                                armorFetch.sortDescriptors = sortDescriptors
                                                palicoFetch.sortDescriptors = sortDescriptors
                                                let predicate = NSPredicate(format: "%K CONTAINS[c] %@", "name", name!)
                                                armorPredicates.append(predicate)
                                                palicoFetch.predicate = predicate
                                                
                                            }
                                            let totalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: armorPredicates)
                                            armorFetch.predicate = totalPredicate
                                            print(armorFetch)
                                            
                                            do {
                                                let fetchedArmor = try moc.fetch(armorFetch) as! [Armor]
                                                self.displayStrings.removeAll()
                                                for armor in fetchedArmor {
                                                    self.displayStrings.append(armor.name! as String!)
                                                    //print(armor.name! as String)
                                                }
//                                                let fetchPal = try moc.fetch(palicoFetch) as! [PalicoArmor]
//                                                for palico in fetchPal{
//                                                    self.displayStrings.append(palico.name! as String!)
//                                                }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.shouldPerformAdvSearch) {
            let firstFilterArr = appDelegate.filterOneArr
            let secondFilterArr = appDelegate.filterTwoArr
            let thirdFilterArr = appDelegate.filterThreeArr
            let fourthFilterArr = appDelegate.filterFourArr
            print(firstFilterArr)
            var shouldUseFirstFilter = false
            var shouldUseSecondFilter = false
            var shouldUseThirdFilter = false
            var shouldUseFourthFilter = false
            for filter in firstFilterArr {
                if (filter != 0) {
                    shouldUseFirstFilter = true
                }
            }
            for filter in secondFilterArr {
                if (filter != 0) {
                    shouldUseSecondFilter = true
                }
            }
            for filter in thirdFilterArr {
                if (filter != 0) {
                    shouldUseThirdFilter = true
                }
            }
            if (fourthFilterArr[0] != 1 || fourthFilterArr[1] != 100) {
                shouldUseFourthFilter = true
            }
            
            
            
            
            let moc = appDelegate.managedObjectContext
            let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sortDescriptor1,sortDescriptor2]
            armorFetch.sortDescriptors = sortDescriptors
            print(armorFetch)
            
            var totalPredicateArr = [NSCompoundPredicate]()
            
            if (shouldUseFirstFilter) {
                var predicateArr = [NSPredicate]()
                if (firstFilterArr[0] == 1) {
                    predicateArr.append(NSPredicate(format: "%K LIKE %@", "slot", "Head"))
                }
                if (firstFilterArr[1] == 1) {
                    predicateArr.append(NSPredicate(format: "%K LIKE %@", "slot", "Chest"))
                }
                if (firstFilterArr[2] == 1) {
                    predicateArr.append(NSPredicate(format: "%K LIKE %@", "slot", "Arms"))
                }
                if (firstFilterArr[3] == 1) {
                    predicateArr.append(NSPredicate(format: "%K LIKE %@", "slot", "Waist"))
                }
                if (firstFilterArr[4] == 1) {
                    predicateArr.append(NSPredicate(format: "%K LIKE %@", "slot", "Legs"))
                }
                print(predicateArr)
                let firstPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicateArr)
                totalPredicateArr.append(firstPredicate)
            }
            if (shouldUseSecondFilter) {
                var predicateArr = [NSPredicate]()
                if (secondFilterArr[0] == 1) {
                    predicateArr.append(NSPredicate(format: "%K > %d", "fire_res", 0))
                }
                if (secondFilterArr[1] == 1) {
                    predicateArr.append(NSPredicate(format: "%K > %d", "water_res", 0))
                }
                if (secondFilterArr[2] == 1) {
                    predicateArr.append(NSPredicate(format: "%K > %d", "ice_res", 0))
                }
                if (secondFilterArr[3] == 1) {
                    predicateArr.append(NSPredicate(format: "%K > %d", "thunder_res", 0))
                }
                if (secondFilterArr[4] == 1) {
                    predicateArr.append(NSPredicate(format: "%K > %d", "dragon_res", 0))
                }
                let secondPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArr)
                totalPredicateArr.append(secondPredicate)
            }
            if (shouldUseThirdFilter) {
                var predicateArr = [NSPredicate]()
                predicateArr.append(NSPredicate(format: "%K == %d", "hunter_type", 2))
                if (secondFilterArr[0] == 1) {
                    predicateArr.append(NSPredicate(format: "%K == %d", "hunter_type", 0))
                }
                if (secondFilterArr[1] == 1) {
                    predicateArr.append(NSPredicate(format: "%K == %d", "hunter_type", 1))
                }
                let thirdPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicateArr)
                totalPredicateArr.append(thirdPredicate)
            }
            if (shouldUseFourthFilter) {
                var predicateArr = [NSPredicate]()
                predicateArr.append(NSPredicate(format: "%K > %d", "defense", fourthFilterArr[0]))
                predicateArr.append(NSPredicate(format: "%K < %d", "defense", fourthFilterArr[1]))
                let fourthPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArr)
                totalPredicateArr.append(fourthPredicate)
            }
            
            
            
            let totalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: totalPredicateArr)
            
            
            
            
            armorFetch.predicate = totalPredicate
            print(armorFetch)
            
            
            
            
            //let predicateOne = NSPredicate(format: "%K CONTAINS[c] %@", "name", name!)
            
            let fetchedArmor = try! moc.fetch(armorFetch) as! [Armor]
            self.displayStrings.removeAll()
            for armor in fetchedArmor {
                self.displayStrings.append(armor.name! as String!)
                //print(armor.name! as String)
            }
            self.tableView.reloadData()
            
            
            
        } else if (appDelegate.slotSelectedForSearch == 0) {
            let moc = appDelegate.managedObjectContext
            let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sortDescriptor1,sortDescriptor2]
            armorFetch.sortDescriptors = sortDescriptors
            armorFetch.predicate = NSPredicate(format: "%K LIKE %@", "slot", "Head")
            let fetchedArmor = try! moc.fetch(armorFetch) as! [Armor]
            self.displayStrings.removeAll()
            for armor in fetchedArmor {
                self.displayStrings.append(armor.name! as String!)
                //print(armor.name! as String)
            }
            self.tableView.reloadData()
        } else if (appDelegate.slotSelectedForSearch == 1) {
            let moc = appDelegate.managedObjectContext
            let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sortDescriptor1,sortDescriptor2]
            armorFetch.sortDescriptors = sortDescriptors
            armorFetch.predicate = NSPredicate(format: "%K LIKE %@", "slot", "Chest")
            let fetchedArmor = try! moc.fetch(armorFetch) as! [Armor]
            self.displayStrings.removeAll()
            for armor in fetchedArmor {
                self.displayStrings.append(armor.name! as String!)
                //print(armor.name! as String)
            }
            self.tableView.reloadData()
        } else if (appDelegate.slotSelectedForSearch == 2) {
            let moc = appDelegate.managedObjectContext
            let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sortDescriptor1,sortDescriptor2]
            armorFetch.sortDescriptors = sortDescriptors
            armorFetch.predicate = NSPredicate(format: "%K LIKE %@", "slot", "Arms")
            let fetchedArmor = try! moc.fetch(armorFetch) as! [Armor]
            self.displayStrings.removeAll()
            for armor in fetchedArmor {
                self.displayStrings.append(armor.name! as String!)
                //print(armor.name! as String)
            }
            self.tableView.reloadData()
        } else if (appDelegate.slotSelectedForSearch == 3) {
            let moc = appDelegate.managedObjectContext
            let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sortDescriptor1,sortDescriptor2]
            armorFetch.sortDescriptors = sortDescriptors
            armorFetch.predicate = NSPredicate(format: "%K LIKE %@", "slot", "Waist")
            let fetchedArmor = try! moc.fetch(armorFetch) as! [Armor]
            self.displayStrings.removeAll()
            for armor in fetchedArmor {
                self.displayStrings.append(armor.name! as String!)
                //print(armor.name! as String)
            }
            self.tableView.reloadData()
        } else if (appDelegate.slotSelectedForSearch == 4) {
            let moc = appDelegate.managedObjectContext
            let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sortDescriptor1,sortDescriptor2]
            armorFetch.sortDescriptors = sortDescriptors
            armorFetch.predicate = NSPredicate(format: "%K LIKE %@", "slot", "Legs")
            let fetchedArmor = try! moc.fetch(armorFetch) as! [Armor]
            self.displayStrings.removeAll()
            for armor in fetchedArmor {
                self.displayStrings.append(armor.name! as String!)
                //print(armor.name! as String)
            }
            self.tableView.reloadData()
        } else {
            let moc = appDelegate.managedObjectContext
            let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
            let sortDescriptor1 = NSSortDescriptor(key: "slot", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptors = [sortDescriptor1,sortDescriptor2]
            armorFetch.sortDescriptors = sortDescriptors
            let fetchedArmor = try! moc.fetch(armorFetch) as! [Armor]
            self.displayStrings.removeAll()
            for armor in fetchedArmor {
                self.displayStrings.append(armor.name! as String!)
                //print(armor.name! as String)
            }
            self.tableView.reloadData()
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let palRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PalicoArmor")
        
        do {
            let results = try! managedContext.fetch(fetchRequest)
            let palResults = try! managedContext.fetch(palRequest)
            palArmors = palResults as! [PalicoArmor]
            armors = results as! [Armor]
            self.displayStrings.removeAll()
            for armor in armors {
                self.displayStrings.append(armor.name! as String)
            }
            for palico in palArmors {
                self.displayStrings.append(palico.name! as String)
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
        let palRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PalicoArmor")
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
            
            let palResult = try! managedContext.fetch(palRequest)
            palArmors = palResult as! [PalicoArmor]
            
            var palImage : UIImage
            
            if(name.contains("(Palico")){
                for palico in palArmors{
                    if(name == palico.name){
                        if(palico.slot == "Chest"){
                            
                            palImage = UIImage(named: "chest")!
                            cell?.imageView?.image = palImage
                        }
                        if(palico.slot == "Head"){
                            
                          palImage = UIImage(named: "Helm")!
                            cell?.imageView?.image = palImage
                        }
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
