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
    
    var valueToPass = 0;
    
    var headPass = 0;
    var chestPass = 0;
    var armsPass = 0;
    var waistPass = 0;
    var legsPass = 0;
    
    @IBAction func headClicked(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        valueToPass=0;
        headPass = 0;
        chestPass = 1;
        armsPass = 1;
        waistPass = 1;
        legsPass = 1;
        appDelegate.slotSelectedForSearch = valueToPass
    }
    
    @IBAction func chestClick(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        valueToPass=1;
        headPass = 1;
        chestPass = 0;
        armsPass = 1;
        waistPass = 1;
        legsPass = 1;
        appDelegate.slotSelectedForSearch = valueToPass
        print(valueToPass)
    }
    @IBAction func armsClick(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        valueToPass=2;
        headPass = 1;
        chestPass = 1;
        armsPass = 0;
        waistPass = 1;
        legsPass = 1;
        appDelegate.slotSelectedForSearch = valueToPass
    }
    @IBAction func waistClick(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        valueToPass=3;
        headPass = 1;
        chestPass = 1;
        armsPass = 1;
        waistPass = 0;
        legsPass = 1;
        appDelegate.slotSelectedForSearch = valueToPass
    }
    @IBAction func legsClick(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        valueToPass=4;
        headPass = 1;
        chestPass = 1;
        armsPass = 1;
        waistPass = 1;
        legsPass = 0;
        appDelegate.slotSelectedForSearch = valueToPass
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        appDelegate.slotSelectedForSearch = 10
        appDelegate.shouldPerformAdvSearch = false
        
        if (appDelegate.headPassedToSecondView != "") {
            headFilledLabel.text = appDelegate.headPassedToSecondView
        }
        if (appDelegate.chestPassedToSecondView != "") {
            chestFilledLabel.text = appDelegate.chestPassedToSecondView
        }
        if (appDelegate.armsPassedToSecondView != "") {
            armsFilledLabel.text = appDelegate.armsPassedToSecondView
        }
        if (appDelegate.waistPassedToSecondView != "") {
            waistFilledLabel.text = appDelegate.waistPassedToSecondView
        }
        if (appDelegate.legsPassedToSecondView != "") {
            legsFilledLabel.text = appDelegate.legsPassedToSecondView
        }
        
//        if (headPass == 0)
//        {
//            let headName = appDelegate.headPassedToSecondView
//            headFilledLabel.text = headName
//        }
//        
//        if (chestPass == 0)
//        {
//        let chestName = appDelegate.chestPassedToSecondView
//        chestFilledLabel.text = chestName
//        }
//        
//        if (armsPass == 0)
//        {
//        let armsName = appDelegate.armsPassedToSecondView
//        armsFilledLabel.text = armsName
//        }
//        
//        if (waistPass == 0)
//        {
//        let waistName = appDelegate.waistPassedToSecondView
//        waistFilledLabel.text = waistName
//        }
//        
//        if (legsPass == 0)
//        {
//        let legsName = appDelegate.legsPassedToSecondView
//        legsFilledLabel.text = legsName
//        }
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func generateSetId(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let setId = appDelegate.outputString()
        let alert = UIAlertController(title: "ID Generated",
                                      message: "Copy this code to share your current set with friends\n"+setId,
                                      preferredStyle: .alert)
        let searchAction = UIAlertAction(title: "Copy",
                                         style: .default,
                                         handler: { (action:UIAlertAction) -> Void in
                                            
                                            UIPasteboard.general.string = setId
                                            NotificationCenter.default.post(name: .reload, object: nil)
                                            //self.performSegue(withIdentifier: "saveCurrentSegue", sender: nil)
                                            
        })
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default,
                                         handler: { (action: UIAlertAction) -> Void in })
        
        
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        
        present(alert,
                animated: true,
                completion: nil)
    }
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
                                                self.inProgressLabel.text = name
                                                
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
                                            
                                            self.inProgressLabel.text = name
                                            
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
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //_ = appDelegate.outputString()
        //_ = appDelegate.parseOutputString(setString: "mhgc-1310727-0-0-0-0")
        
        headFilledLabel.text = "Empty"
        chestFilledLabel.text = "Empty"
        armsFilledLabel.text = "Empty"
        waistFilledLabel.text = "Empty"
        legsFilledLabel.text = "Empty"
        
        inProgressLabel.text = passedValue
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

