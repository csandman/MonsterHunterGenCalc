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
    
    var tabBarItem1: UITabBarItem = UITabBarItem()
    var tabBarItem2: UITabBarItem = UITabBarItem()
    
    @IBAction func loadSetId(_ sender: Any) {
        let alert = UIAlertController(title: "Load Set from ID",
                                      message: "Paste a set code to load a premade set",
                                      preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Load",
                                         style: .default,
                                         handler: { (action:UIAlertAction) -> Void in
                                            
                                            
                                            let id = alert.textFields![0].text
                                            
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            let currentSet = appDelegate.parseOutputString(setString: id!)
                                            
                                            if (currentSet.head != 0 && currentSet.head != nil) {
                                                let headFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                                                let headPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.head!))
                                                headFetch.predicate = headPredicate
                                                print(headFetch)
                                                var fetchedHead = try! appDelegate.managedObjectContext.fetch(headFetch) as! [Armor]
                                                let head = fetchedHead[0]
                                                appDelegate.headPassedToSecondView = head.name!
                                            }
                                            
                                            if (currentSet.chest != 0 && currentSet.chest != nil) {
                                                let chestFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                                                let chestPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.chest!))
                                                chestFetch.predicate = chestPredicate
                                                var fetchedChest = try! appDelegate.managedObjectContext.fetch(chestFetch) as! [Armor]
                                                let chest = fetchedChest[0]
                                                appDelegate.chestPassedToSecondView = chest.name!
                                            }
                                            
                                            if (currentSet.arms != 0 && currentSet.arms != nil) {
                                                let armsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                                                let armsPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.arms!))
                                                armsFetch.predicate = armsPredicate
                                                var fetchedArms = try! appDelegate.managedObjectContext.fetch(armsFetch) as! [Armor]
                                                let arms = fetchedArms[0]
                                                appDelegate.armsPassedToSecondView = arms.name!
                                            }
                                            
                                            if (currentSet.legs != 0 && currentSet.legs != nil) {
                                                let legsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                                                let legsPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.legs!))
                                                legsFetch.predicate = legsPredicate
                                                var fetchedLegs = try! appDelegate.managedObjectContext.fetch(legsFetch) as! [Armor]
                                                let legs = fetchedLegs[0]
                                                appDelegate.legsPassedToSecondView = legs.name!
                                                
                                            }
                                            
                                            if (currentSet.waist != 0 && currentSet.waist != nil) {
                                                let waistFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                                                let waistPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.waist!))
                                                waistFetch.predicate = waistPredicate
                                                var fetchedWaist = try! appDelegate.managedObjectContext.fetch(waistFetch) as! [Armor]
                                                let waist = fetchedWaist[0]
                                                appDelegate.waistPassedToSecondView = waist.name!
                                            }
                                            
                                            NotificationCenter.default.post(name: .reload, object: nil)
                                            self.performSegue(withIdentifier: "setIdSegue", sender: nil)
                                            
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
    

    @IBOutlet weak var humanPalico: UISegmentedControl!
    
    
    @IBOutlet weak var savedTable: UITableView!
    
    //@IBOutlet weak var progressTable: UITableView!
    
    
  
    
    @IBOutlet weak var startBuild: UIButton!
    
    //@IBOutlet weak var savedLabel: UILabel!
    
    @IBOutlet weak var savedLabel: UILabel!
    
    //@IBOutlet weak var progressLabel: UILabel!
    
   
    //@IBOutlet weak var progressLabel: UILabel!
    
    var namesSaved = [String]()
    var namesSavedPal = [String]()
    var namesProgress = [String]()
    var namesProgressPal = [String]()
    
   
    
    var builds = [Builds]()
    
    @IBAction func indexChange(_ sender: Any) {
        switch humanPalico.selectedSegmentIndex
        {
        case 0:
            self.savedTable.reloadData()
            //self.progressTable.reloadData()
            break;
        
        case 1:
            self.savedTable.reloadData()
            //self.progressTable.reloadData()
            break;
            
        default:
          break;
        
        }
        
    }
    
    @IBAction func startNewBuild(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.createNewSet()
        appDelegate.headPassedToSecondView = "Empty"
        appDelegate.chestPassedToSecondView = "Empty"
        appDelegate.armsPassedToSecondView = "Empty"
        appDelegate.legsPassedToSecondView = "Empty"
        appDelegate.waistPassedToSecondView = "Empty"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
        let sortDescriptor = NSSortDescriptor(key: "setName", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            let results = try! managedContext.fetch(fetchRequest)
            let buildsList = results as! [Builds]
            self.namesSaved.removeAll()
            for build in buildsList {
                self.namesSaved.append(build.setName as! String)
            }
        }
        self.savedTable.reloadData()
        
        
        humanPalico.setTitle("Hunter", forSegmentAt: 0)
        
        savedLabel.textAlignment = NSTextAlignment.center;
        //progressLabel.textAlignment = NSTextAlignment.center;
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        savedTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        self.savedTable.reloadData()
        
        //savedTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //progressTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
       
    }
    
    func reloadTableData(_ notification: Notification){
        savedTable.reloadData()
    }

    //Delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //theoretically saves names of deleted builds in this array
        var tempNames = [String]()
        
        if editingStyle == .delete {
            if(humanPalico.selectedSegmentIndex==0){
                if tableView == savedTable{
                    
                    //puts name of build to be deleted in the temp array
                    tempNames.append(namesSaved[indexPath.row])
                    
                    //removes from name array and table
                    namesSaved.remove(at: indexPath.row)
                     savedTable.deleteRows(at: [indexPath], with: .fade)
                }
                else{
                    tempNames.append(namesProgress[indexPath.row])
                    namesProgress.remove(at: indexPath.row)
                    //progressTable.deleteRows(at: [indexPath], with: .fade)
                }
               
            }
            else{
                if tableView == savedTable{
                    tempNames.append(namesSavedPal[indexPath.row])
                    namesSavedPal.remove(at: indexPath.row)
                    savedTable.deleteRows(at: [indexPath], with: .fade)
                }
                else{
                    tempNames.append(namesProgressPal[indexPath.row])
                    namesProgressPal.remove(at: indexPath.row)
                    //progressTable.deleteRows(at: [indexPath], with: .fade)
                }
            }
            
            
            
            var names = [Builds]()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
            
            do {
                let results =
                    try managedContext.fetch(fetchRequest)
                names = results as! [Builds]
                
                
                //Iterates through the builds, and if one has a name matching one of the deleted sets, deletes from coredata
                for n in names
                {
                    for temp in tempNames{
                        if n.setName! as String == temp{
                            managedContext.delete(n)
                            
                        }
                    }
                }
                try managedContext.save()
                
            } catch let error as NSError {
                print("delete failed \(error), \(error.userInfo)")
            }

        }
        
        
        
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if(humanPalico.selectedSegmentIndex == 0)
        {
            //if tableView == savedTable{
        
                return self.namesSaved.count
            
            //}
            //else{
                //return self.namesProgress.count
            //}
        }
        else{
                //if tableView == savedTable{
                    return self.namesSavedPal.count
                //}
                //e//lse{
                    //return self.namesProgressPal.count
                //}
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
        //if tableView == savedTable{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSaved")
        
        cell!.textLabel!.text = namesSaved[indexPath.row]
         cell!.textLabel!.textColor=UIColor.white; //changes the text color for a cell
     
        return cell!
        //}
        //else{
            //let cell2 = tableView.dequeueReusableCell(withIdentifier: "CellProgress")
            // cell2!.textLabel!.text = namesProgress[indexPath.row]
            // cell2!.textLabel!.textColor=UIColor.white; //changes the text color for a cell
       //
           // return cell2!
          //  }
        }
        else{
           //if tableView == savedTable{
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSaved")
                
                cell!.textLabel!.text = namesSavedPal[indexPath.row]
                 cell!.textLabel!.textColor=UIColor.white; //changes the text color for a cell
           
                return cell!
           // }
            //else{
               // let cell2 = tableView.dequeueReusableCell(withIdentifier: "CellProgress")
              //  cell2!.textLabel!.text = namesProgressPal[indexPath.row]
              //   cell2!.textLabel!.textColor=UIColor.white; //changes the text color for a //cell
            
             //   return cell2!
            //}
        }
        
        //coredata
            /*let cell = tableView.dequeueReusableCell(withIdentifier: "CellSaved")
            
            let person = people[indexPath.row]
            
            cell!.textLabel!.text = person.value(forKey: "name") as? String
            
            return cell!*/
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savedSegue" {
            
            /*let selectedIndex = sender as! NSIndexPath
             let currentCell =  savedTable.cellForRow(at: selectedIndex as IndexPath)! as UITableViewCell
             self.valueToPass = currentCell.textLabel!.text!*/
            
            if let indexPath = self.savedTable.indexPathForSelectedRow{
                let controller = segue.destination as! SecondViewController
                controller.passedValue = namesSaved[indexPath.row]
                let appDelegate =
                    UIApplication.shared.delegate as! AppDelegate
                let currentSet = appDelegate.loadExistingSet(name: controller.passedValue!)
                print(currentSet)
                if (currentSet.head != 0 && currentSet.head != nil) {
                    let headFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                    let headPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.head!))
                    headFetch.predicate = headPredicate
                    print(headFetch)
                    var fetchedHead = try! appDelegate.managedObjectContext.fetch(headFetch) as! [Armor]
                    let head = fetchedHead[0]
                    appDelegate.headPassedToSecondView = head.name!
                } else {
                    appDelegate.chestPassedToSecondView = "Empty"
                }
                
                if (currentSet.chest != 0 && currentSet.chest != nil) {
                let chestFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                let chestPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.chest!))
                chestFetch.predicate = chestPredicate
                var fetchedChest = try! appDelegate.managedObjectContext.fetch(chestFetch) as! [Armor]
                let chest = fetchedChest[0]
                    appDelegate.chestPassedToSecondView = chest.name!
                } else {
                    appDelegate.chestPassedToSecondView = "Empty"
                }
                
                if (currentSet.arms != 0 && currentSet.arms != nil) {
                let armsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                let armsPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.arms!))
                armsFetch.predicate = armsPredicate
                var fetchedArms = try! appDelegate.managedObjectContext.fetch(armsFetch) as! [Armor]
                let arms = fetchedArms[0]
                    appDelegate.armsPassedToSecondView = arms.name!
                } else {
                    appDelegate.chestPassedToSecondView = "Empty"
                }
                
                if (currentSet.legs != 0 && currentSet.legs != nil) {
                let legsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                let legsPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.legs!))
                legsFetch.predicate = legsPredicate
                var fetchedLegs = try! appDelegate.managedObjectContext.fetch(legsFetch) as! [Armor]
                let legs = fetchedLegs[0]
                    appDelegate.legsPassedToSecondView = legs.name!
                    
                } else {
                    appDelegate.chestPassedToSecondView = "Empty"
                }
                
                if (currentSet.waist != 0 && currentSet.waist != nil) {
                let waistFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
                let waistPredicate = NSPredicate(format: "%K == %d", "id", Int(currentSet.waist!))
                waistFetch.predicate = waistPredicate
                var fetchedWaist = try! appDelegate.managedObjectContext.fetch(waistFetch) as! [Armor]
                let waist = fetchedWaist[0]
                    appDelegate.waistPassedToSecondView = waist.name!
                } else {
                    appDelegate.chestPassedToSecondView = "Empty"
                }
                
                
                
                
                
                

            }
            
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.savedTable.setEditing(editing, animated: animated)
       // self.progressTable.setEditing(editing, animated: animated)
    }

    

    
    //var armors = [Armor]()
    //var builds = [Builds]()
    //var displayStrings = [String]()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let tabBarControllerItems = self.tabBarController?.tabBar.items
        
        if let tabArray = tabBarControllerItems {
            self.tabBarItem2 = tabArray[1]
            self.tabBarItem2.isEnabled = true
        }
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabBarControllerItems = self.tabBarController?.tabBar.items
        
        if let tabArray = tabBarControllerItems {
            self.tabBarItem2 = tabArray[1]
            self.tabBarItem2.isEnabled = false
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.headPassedToSecondView = "Empty"
        appDelegate.chestPassedToSecondView = "Empty"
        appDelegate.armsPassedToSecondView = "Empty"
        appDelegate.legsPassedToSecondView = "Empty"
        appDelegate.waistPassedToSecondView = "Empty"
        
        let managedContext = appDelegate.managedObjectContext
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
        let sortDescriptor = NSSortDescriptor(key: "setName", ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            let results = try! managedContext.fetch(fetchRequest)
            let buildsList = results as! [Builds]
            self.namesSaved.removeAll()
            for build in buildsList {
                self.namesSaved.append(build.setName as! String)
            }
        }
        self.savedTable.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

