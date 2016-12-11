//
//  SecondViewController.swift
//  MHGenCalc
//
//  Created by Student on 11/17/16.
//  Copyright © 2016 Student. All rights reserved.
//

//TODO
// If you make a build thru save stats go back without clicking save build, it still saves the build maybe the armor
// Edit needs to be off before you click start a new build
//
import UIKit

extension Notification.Name {
    static let reload = Notification.Name("reload")
}
class SecondViewController: UIViewController {
    
    var passedValue: String?
    
    //chris, outlets for the labels that should appear when an armor slot is filled in
    @IBOutlet weak var headFilledLabel: UILabel!
    @IBOutlet weak var chestFilledLabel: UILabel!
    @IBOutlet weak var armsFilledLabel: UILabel!
    @IBOutlet weak var waistFilledLabel: UILabel!
    @IBOutlet weak var legsFilledLabel: UILabel!
    
    @IBAction func addArmorInProgress(_ sender: UIButton) {
    }

    @IBOutlet weak var inProgressLabel: UITextField!
    
    @IBAction func loadStats(_ sender: Any) {
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //appDelegate.totalStats(build: appDelegate.currentSetArr[0])
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let setName = appDelegate.currentSetArr[0].setName
        
        if (setName == "" || setName == nil) {
            let alert = UIAlertController(title: "Set Name",
                                          message: "Please enter a name for the set first",
                                          preferredStyle: .alert)
            let searchAction = UIAlertAction(title: "Save",
                                             style: .default,
                                             handler: { (action:UIAlertAction) -> Void in
                                                
                                                
                                                let name = alert.textFields![0].text
                                                
                                                
                                                _ = appDelegate.saveSet(name: name!)
                                                NotificationCenter.default.post(name: .reload, object: nil)
                                                self.performSegue(withIdentifier: "statSegue", sender: nil)
                                                
            })
            
            
            
            alert.addTextField {
                (textField: UITextField) -> Void in
            }
            
            
            alert.addAction(searchAction)
            
            present(alert,
                    animated: true,
                    completion: nil)
        }
        
    }
    @IBAction func saveBuild(_ sender: Any) {
        print("working")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let setName = appDelegate.currentSetArr[0].setName
        
        if (setName == "" || setName == nil) {
        let alert = UIAlertController(title: "Set Name",
                                      message: "Enter a name for the set",
                                      preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Save",
                                         style: .default,
                                         handler: { (action:UIAlertAction) -> Void in
                                            
                                            
                                            let name = alert.textFields![0].text
                                            
                                            
                                            _ = appDelegate.saveSet(name: name!)
                                            
                                        NotificationCenter.default.post(name: .reload, object: nil)
                                            //self.performSegue(withIdentifier: "saveCurrentSegue", sender: nil)
                                            
        })
        
        
        
        alert.addTextField {
            (textField: UITextField) -> Void in
        }
        
        
        alert.addAction(searchAction)
        
        present(alert,
                animated: true,
                completion: nil)
        } else {
            let alert = UIAlertController(title: "Set Saved",
                                          message: "You have successfully saved the set",
                                          preferredStyle: .alert)
            let searchAction = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: { (action:UIAlertAction) -> Void in
                                                
                                                _ = appDelegate.saveSet(name: setName as! String)
                                                NotificationCenter.default.post(name: .reload, object: nil)
                                                //self.performSegue(withIdentifier: "saveCurrentSegue", sender: nil)
                                                
            })
            
            
            alert.addAction(searchAction)
            
            present(alert,
                    animated: true,
                    completion: nil)
            
        }
        //self.performSegue(withIdentifier: "saveCurrentSegue", sender: nil)
        
    }
    
    
    
    @IBAction func PalicoInProgress(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
        }
        else{
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        _ = appDelegate.outputString()
        //_ = appDelegate.parseOutputString(setString: "mhgc-1310727-0-0-0-0")
        inProgressLabel.text = passedValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

