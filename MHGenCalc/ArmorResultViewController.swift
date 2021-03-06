//
//  SecondViewController.swift
//  MHGenCalc
//
//  Created by Student on 11/17/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
import CoreData

class ArmorResultViewController: UIViewController {
    
    var armorValue: String?
    
    
    @IBOutlet weak var armorImage: UIImageView!

    @IBOutlet weak var armorLabel: UILabel!
   
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    @IBOutlet weak var maxDefenseLabel: UILabel!
    
    @IBOutlet weak var thunderLabel: UILabel!
    @IBOutlet weak var dragonLabel: UILabel!
    
    @IBOutlet weak var waterLabel: UILabel!
    
    @IBOutlet weak var fireLabel: UILabel!
    
    @IBAction func addArmorToSet(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.addArmorPieceByName(self.armorValue!)
        
        let armorFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let armorPredicate = NSPredicate(format: "%K == %@", "name", armorValue!)
        armorFetch.predicate = armorPredicate
        var fetchedArmor = try! appDelegate.managedObjectContext.fetch(armorFetch) as! [Armor]
        let armor = fetchedArmor[0]
        if (armor.slot == "Head") {
            appDelegate.headPassedToSecondView = armor.name!
        } else if (armor.slot == "Chest") {
            appDelegate.chestPassedToSecondView = armor.name!
        } else if (armor.slot == "Arms") {
            appDelegate.armsPassedToSecondView = armor.name!
        } else if (armor.slot == "Waist") {
            appDelegate.waistPassedToSecondView = armor.name!
        } else if (armor.slot == "Legs") {
            appDelegate.legsPassedToSecondView = armor.name!
        }
        //appDelegate.headPassedToSecondView = head.name!
        
        
//        var addArmorNameToPass = armorValue
//        appDelegate.headPassedToSecondView = addArmorNameToPass!
//
//        appDelegate.chestPassedToSecondView = addArmorNameToPass!
//        
//        appDelegate.armsPassedToSecondView = addArmorNameToPass!
//        
//        appDelegate.waistPassedToSecondView = addArmorNameToPass!
//        
//        appDelegate.legsPassedToSecondView = addArmorNameToPass!
        
        let alert = UIAlertController(title: "Armor Added",
                                      message: "You have added this item to your current set",
                                      preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: { (action:UIAlertAction) -> Void in
                                            
                                            //self.performSegue(withIdentifier: "searchAddSegue", sender: nil)
                                            self.navigationController?.popViewController(animated: true)
                                            self.navigationController?.popViewController(animated: true)
                                            
                                            
        })
        
        
        
        alert.addAction(searchAction)
        
        present(alert,
                animated: true,
                completion: nil)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        armorLabel.text = armorValue
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Armor")
        let palicoRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PalicoArmor")
        do{
            let results = try! managedContext.fetch(fetchRequest)
            let palResults = try! managedContext.fetch(palicoRequest)
            let armors = results as! [Armor]
            let palicos = palResults as! [PalicoArmor]
            for armor in armors{
                if(armor.name == armorValue){
                        defenseLabel.text = "\(armor.defense!)"
                        maxDefenseLabel.text = "\(armor.max_defense!)"
                        iceLabel.text = "\(armor.ice_res!)"
                        thunderLabel.text = "\(armor.thunder_res!)"
                        dragonLabel.text = "\(armor.dragon_res!)"
                        waterLabel.text = "\(armor.water_res!)"
                        fireLabel.text = "\(armor.fire_res!)"
                    
                    var imageArmor : UIImage
                        if(armor.slot == "Chest"){
                            
                            imageArmor = UIImage(named: "chest")!
                            armorImage.image = imageArmor
                        }
                        else if(armor.slot == "Arms"){
                            
                            imageArmor = UIImage(named: "arms")!
                            armorImage.image = imageArmor
                        }
                        else if(armor.slot == "Legs"){
                            
                            imageArmor = UIImage(named: "leg")!
                            armorImage.image = imageArmor
                        }
                        else if(armor.slot == "Waist"){
                            
                            imageArmor = UIImage(named: "wait")!
                            armorImage.image = imageArmor
                                                    }
                        else if(armor.slot == "Head"){
                            
                            imageArmor = UIImage(named: "Helm")!
                            armorImage.image = imageArmor
                        }
                    


                }
                
                if(armorValue?.contains("(Palico)"))! {
                for palico in palicos{
                    if(palico.name == armorValue){
                        
                        defenseLabel.text = "\(palico.defense!)"
                        maxDefenseLabel.text = "N/A"
                        iceLabel.text = "\(palico.ice_res!)"
                        thunderLabel.text = "\(palico.thunder_res!)"
                        //dragonLabel.text = "\(armor.dragon_res!)"
                        dragonLabel.text = "0"
                        waterLabel.text = "\(palico.water_res!)"
                        fireLabel.text = "\(palico.fire_res!)"
                        
                        var imageArmor : UIImage
                        if(palico.slot == "Chest"){
                            
                            imageArmor = UIImage(named: "chest")!
                            armorImage.image = imageArmor
                        }
                        else if(palico.slot == "Head"){
                            
                            imageArmor = UIImage(named: "Helm")!
                            armorImage.image = imageArmor
                        }
                        
                        
                        
                    }
                
                }
            
            }
        }
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

