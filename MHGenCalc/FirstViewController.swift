//
//  FirstViewController.swift
//  MHGenCalc
//
//  Created by Student on 11/17/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var humanPalico: UISegmentedControl!
    
    
    @IBOutlet weak var savedTable: UITableView!
    
    @IBOutlet weak var progressTable: UITableView!
    
    
    @IBOutlet weak var startBuild: UIButton!
    
    
    //@IBOutlet weak var savedLabel: UILabel!
    
    @IBOutlet weak var savedLabel: UILabel!
    
    //@IBOutlet weak var progressLabel: UILabel!
    
   
    @IBOutlet weak var progressLabel: UILabel!
    
    var namesSaved = [String]()
    var namesSavedPal = [String]()
    var namesProgress = [String]()
    var namesProgressPal = [String]()
    
    //var people = [Person]()
    
    @IBAction func indexChange(_ sender: Any) {
        switch humanPalico.selectedSegmentIndex
        {
        case 0:
            self.savedTable.reloadData()
            self.progressTable.reloadData()
            break;
        
        case 1:
            self.savedTable.reloadData()
            self.progressTable.reloadData()
            break;
            
        default:
          break;
        
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        savedLabel.textAlignment = NSTextAlignment.center;
        progressLabel.textAlignment = NSTextAlignment.center;
        
        //savedTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let palText = "CATCATCAT"
        self.namesSavedPal.append(palText)
        let textField = "Wheee"
        self.namesSaved.append(textField)
        let text2 = "asasas"
        self.namesSaved.append(text2)
        let text3 = "sasdasdasds"
        self.namesSaved.append(text3)
        let text4 = "asdads"
        self.namesSaved.append(text4)
        let text5 = "i dunno"
        self.namesProgress.append(text5)
        let text6 = "yeah!!!"
        self.namesProgressPal.append(text6)
        self.savedTable.reloadData()
        
        //savedTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //progressTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //let appDelegate =
           // UIApplication.shared.delegate as! AppDelegate
        
        //let managedContext = appDelegate.managedObjectContext
        
        //let entity =  NSEntityDescription.entity(forEntityName: "Person", in:managedContext)
        //let person = Person(entity: entity!, insertInto: managedContext)
        
        /*person.name = "aaaaaa"
        
        do {
           try managedContext.save()
           people.append(person)
    } catch let error as NSError  {
          print("Could not save \(error), \(error.userInfo)")
    }
        
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let results =
             try managedContext.fetch(fetchRequest)
            people = results as! [Person]
            
            
            
          for p in people
           {
               people.append(p)
                self.namesSaved.append(p.name!)
            
            }
            
           self.savedTable.reloadData()
            
            
                
        
       } catch let error as NSError {
        print("fetch or save failed \(error), \(error.userInfo)")
       }*/
    }

    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if(humanPalico.selectedSegmentIndex == 0)
        {
            if tableView == savedTable{
        
                return self.namesSaved.count
            
            }
            else{
                return self.namesProgress.count
            }
        }
        else{
                if tableView == savedTable{
                    return self.namesSavedPal.count
                }
                else{
                    return self.namesProgressPal.count
                }
            }
        
        //coredata
        /*if(humanPalico.selectedSegmentIndex == 0)
        {
            if tableView == savedTable{
                
                return namesSaved.count
                
        }
        }*/
        
        //return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        if(humanPalico.selectedSegmentIndex == 0)
        {
        if tableView == savedTable{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSaved")
        
        cell!.textLabel!.text = namesSaved[indexPath.row]
        
        return cell!
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "CellProgress")
             cell2!.textLabel!.text = namesProgress[indexPath.row]
            return cell2!
            }
        }
        else{
            if tableView == savedTable{
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSaved")
                
                cell!.textLabel!.text = namesSavedPal[indexPath.row]
                
                return cell!
            }
            else{
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "CellProgress")
                cell2!.textLabel!.text = namesProgressPal[indexPath.row]
                return cell2!
            }
        }
        
        //coredata
            /*let cell = tableView.dequeueReusableCell(withIdentifier: "CellSaved")
            
            let person = people[indexPath.row]
            
            cell!.textLabel!.text = person.value(forKey: "name") as? String
            
            return cell!*/
        
    }

    
    var people = [Person]()
    var armors = [Armor]()
    var builds = [Builds]()
    var displayStrings = [String]()
    var currentSet: [String: String] = ["setName":""]
    
    
    func lookupName(name: String) -> Person?
    {
        for p in people
        {
            if (name == p.name) { return p }
        }
        return nil
    }
    
    
    /*func saveName(name: String) -> Person
    {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Person", in:managedContext)
        let person = Person(entity: entity!, insertInto: managedContext)
        
        person.name = name
        
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return person
    }*/
    
   /* func createNewSet() {
        self.saveSet()
        self.currentSet = ["setName":""]
        //switch to set page
    }
    
    func addArmorPiece(armorPiece: Armor) {
        let armorId = armorPiece.id
        let armorType = armorPiece.slot!.lowercased()
        
        self.currentSet[armorType] = String(describing: armorId)
        
    }*/
    
   /* func saveSet() -> Builds {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entity(forEntityName: "Builds", in:managedContext)
        var build = Builds(entity: entity!, insertInto: managedContext)
        
        var tempSet = self.currentSet
        if (tempSet["setName"]! == "") {
            
            let alert = UIAlertController(title: "Enter Set Name",
                                          message: "Enter a name for the set",
                                          preferredStyle: .alert)
            let addTitleAction = UIAlertAction(title: "AddSetName",
                                               style: .default,
                                               handler: { (action:UIAlertAction) -> Void in
                                                
                                                let name = alert.textFields![0].text
                                                print(name!)
                                                build.setName = name as NSString?
            })
            
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .default,
                                             handler: { (action: UIAlertAction) -> Void in })
            
            alert.addTextField {
                (textField: UITextField) -> Void in
            }
            
            
            alert.addAction(addTitleAction)
            alert.addAction(cancelAction)
            
            present(alert,
                                  animated: true,
                                  completion: nil)
            
            
            
            //save as new set
            /*build.head = Int(tempSet["head"])
            build.chest = Int(tempSet["chest"])
            build.arms = Int(tempSet["arms"])
            build.waist = Int(tempSet["waist"])
            build.legs = Int(tempSet["legs"])*/
            
            
            do {
                try managedContext.save()
                self.builds.append(build)
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        } else {
            //check to see if set exists.  if it does, update it, if it does not, save it as new
            let buildFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
            let predicate = NSPredicate(format: "%K LIKE %@", "setName", tempSet["setName"]!)
            buildFetch.predicate = predicate
            do {
                let fetchedBuilds = try managedContext.fetch(buildFetch) as! [Builds]
                build = fetchedBuilds[0]
                //save as new set
               /* build.head = Int(tempSet["head"])
                build.chest = Int(tempSet["chest"])
                build.arms = Int(tempSet["arms"])
                build.waist = Int(tempSet["waist"])
                build.legs = Int(tempSet["legs"])*/
                
                do {
                    try managedContext.save()
                    self.builds.append(build)
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            } catch {
                fatalError("Failed to fetch armor: \(error)")
            }
            
        }
        
        return build
    }*/
    
    /*func saveArmor(line: String) -> Armor
    {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Armor", in:managedContext)
        let armor = Armor(entity: entity!, insertInto: managedContext)
        
        let fields = line.componentsSeparatedByString(",")
        
        armor.name = fields[11]
        armor.id = Int(fields[0])
        armor.slot = fields[1]
        armor.defense = Int(fields[2])
        armor.max_defense = Int(fields[3])
        armor.fire_res = Int(fields[4])
        armor.thunder_res = Int(fields[5])
        armor.dragon_res = Int(fields[6])
        armor.water_res = Int(fields[7])
        armor.ice_res = Int(fields[8])
        armor.hunter_type = Int(fields[9])
        armor.num_slots = Int(fields[10])
        armor.rarity = Int(fields[12])
        
     
        do {
            try managedContext.save()
            armors.append(armor)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        self.displayStrings.append(armor.name! + " has " + String(describing: armor.ice_res!) + " ice resistance")
        return armor
    }*/
 
    /*func saveShoes(person: Person, style: String)
    {
        let appDelegate =
            UIApplication.sharedApplication.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Shoes", inManagedObjectContext:managedContext)
        let shoes = Shoes(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        shoes.style = style
        person.wardrobe!.setByAddingObject(shoes)
        shoes.owner = person
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }*/
    
    //    @IBAction func search(sender: AnyObject) {
    //        let alert = UIAlertController(title: "Search",
    //            message: "Search for an existing entry",
    //            preferredStyle: .Alert)
    //    }
        /*@IBAction func addName(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Name/Shoes",
                                      message: "Add a new name/shoes combo",
                                      preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        
                                        let nameField = alert.textFields![0]
                                        var p = self.lookupName(nameField.text!)
                                        
                                        if (p == nil)
                                        {
                                            p = self.saveName(nameField.text!)
                                        }
                                        
                                        let shoeField = alert.textFields![1]
                                        self.saveShoes(p!, style: shoeField.text!)
                                        
                                        self.displayStrings.append(p!.name! + " owns " + shoeField.text!)
                                        self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Default,
                                         handler: { (action: UIAlertAction) -> Void in })
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
                              animated: true,
                              completion: nil)
    }*/
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

