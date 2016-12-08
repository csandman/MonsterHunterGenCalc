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
    
   
    
    var builds = [Builds]()
    
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
        
        humanPalico.setTitle("Hunter", forSegmentAt: 0)
        
        savedLabel.textAlignment = NSTextAlignment.center;
        progressLabel.textAlignment = NSTextAlignment.center;
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        savedTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        
        savedTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        progressTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //appDelegate.addArmorPieceById(1311031)
        //appDelegate.addArmorPieceById(1376337)
        //appDelegate.addArmorPieceById(1441869)
        //appDelegate.addArmorPieceById(1507453)
        //appDelegate.addArmorPieceById(1572902)
       
        
        let managedContext = appDelegate.managedObjectContext
        
        //let entity =  NSEntityDescription.entity(forEntityName: "Builds", in:managedContext)
        //let person = Person(entity: entity!, insertInto: managedContext)
        
        /*person.name = "aaaaaa"
        
        do {
           try managedContext.save()
           people.append(person)
    } catch let error as NSError  {
          print("Could not save \(error), \(error.userInfo)")
    }*/
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Builds")
        
        do {
            let results =
             try managedContext.fetch(fetchRequest)
            builds = results as! [Builds]
            
            
            
           for b in builds
           {
                /*if saved build{
                    if human build{
                        self.namesSaved.append(b.name!)
                    }
                    else{
                        self.namesSavedPal.append(b.name!)
                    }
                }
             
                else{
                    if human build{
                        self.namesProgress.append(b.name!)
                    }
                    else{
                        self.namesProgressPal.append(b.name!)
                }
             }
 
            */
            
            }
            
           self.savedTable.reloadData()
           self.progressTable.reloadData()
            
            
                
        
       } catch let error as NSError {
        print("fetch or save failed \(error), \(error.userInfo)")
       }
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
                    progressTable.deleteRows(at: [indexPath], with: .fade)
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
                    progressTable.deleteRows(at: [indexPath], with: .fade)
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
         cell!.textLabel!.textColor=UIColor.white; //changes the text color for a cell
     
        return cell!
        }
        else{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "CellProgress")
             cell2!.textLabel!.text = namesProgress[indexPath.row]
             cell2!.textLabel!.textColor=UIColor.white; //changes the text color for a cell
       
            return cell2!
            }
        }
        else{
            if tableView == savedTable{
                let cell = tableView.dequeueReusableCell(withIdentifier: "CellSaved")
                
                cell!.textLabel!.text = namesSavedPal[indexPath.row]
                 cell!.textLabel!.textColor=UIColor.white; //changes the text color for a cell
           
                return cell!
            }
            else{
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "CellProgress")
                cell2!.textLabel!.text = namesProgressPal[indexPath.row]
                 cell2!.textLabel!.textColor=UIColor.white; //changes the text color for a cell
            
                return cell2!
            }
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
                _ = appDelegate.loadExistingSet(name: controller.passedValue!)
            }
            
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.savedTable.setEditing(editing, animated: animated)
        self.progressTable.setEditing(editing, animated: animated)
    }

    

    
    //var armors = [Armor]()
    //var builds = [Builds]()
    //var displayStrings = [String]()
    
    
    
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

