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

    
    var armors = [Armor]()
    var builds = [Builds]()
    var displayStrings = [String]()
    
    
    
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

