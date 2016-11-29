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
    
    
    @IBOutlet weak var savedLabel: UILabel!
    
    
    @IBOutlet weak var progressLabel: UILabel!
    
   
    var displayStrings = [String]()
    //var people = [Person]()
    @IBAction func indexChange(_ sender: Any) {
        //switch segmentedControl.selectedSegmentIndex
        //{
        //case 0:
        //Display human saved/in-progress builds
        
        //case 1:
        //Display palico saved/in-progress builds
        //default:
        //  break;
        
        //}
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        savedLabel.textAlignment = NSTextAlignment.center;
        progressLabel.textAlignment = NSTextAlignment.center;
        
        //savedTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //progressTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //let appDelegate =
            //UIApplication.shared.delegate as! AppDelegate
        
        //let managedContext = appDelegate.managedObjectContext
        
        //let entity =  NSEntityDescription.entity(forEntityName: "Person", in:managedContext)
        //let person = Person(entity: entity!, insertInto: managedContext)
        
        //person.name = "aaaaaa"
        
        //do {
        //    try managedContext.save()
       //     people.append(person)
        //} catch let error as NSError  {
       //     print("Could not save \(error), \(error.userInfo)")
       // }
        
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
       // do {
        //    let results =
        //        try managedContext.fetch(fetchRequest)
         //   people = results as! [Person]
            
         //   for p in people
         //   {
         //       people.append(p)
         //       self.displayStrings.append(p.name!)
         //       print(p.name!)
          //  }
            
         //   self.savedTable.reloadData()
            
            
                
            
       // } catch let error as NSError {
        //    print("fetch or save failed \(error), \(error.userInfo)")
      //  }
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
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

