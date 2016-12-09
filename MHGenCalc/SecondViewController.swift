//
//  SecondViewController.swift
//  MHGenCalc
//
//  Created by Student on 11/17/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var passedValue: String?
    
    @IBAction func addArmorInProgress(_ sender: UIButton) {
    }

    @IBOutlet weak var inProgressLabel: UITextField!
    
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
                                                
            })
            
            
            alert.addAction(searchAction)
            
            present(alert,
                    animated: true,
                    completion: nil)
        }
        
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
        
        
        inProgressLabel.text = passedValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

