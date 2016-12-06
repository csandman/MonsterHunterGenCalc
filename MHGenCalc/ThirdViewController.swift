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
                                                    self.displayStrings.append(armor.name! as String!)
                                                    print(armor.name! as String)
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
        
        appDelegate.addArmorPieceById(1311031)
        appDelegate.addArmorPieceById(1376337)
        appDelegate.addArmorPieceById(1441869)
        appDelegate.addArmorPieceById(1507453)
        appDelegate.addArmorPieceById(1572902)
        print(appDelegate.currentSet)
        print(appDelegate.saveSet())
        let set = appDelegate.loadExistingSet(name: "test1")
        print(set)
        appDelegate.totalStats(build: set)
        
        
        
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
        
        return cell!
    }
}
