//
//  Filter2ViewController.swift
//  MHGenCalc
//
//  Created by Student on 12/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class Filter2ViewController: UIViewController {

    @IBOutlet weak var elementLabel: UILabel!
    
    @IBOutlet weak var fireSwitch: UISwitch!
    @IBOutlet weak var waterSwitch: UISwitch!
    @IBOutlet weak var iceSwitch: UISwitch!
    @IBOutlet weak var thunderSwitch: UISwitch!
    @IBOutlet weak var dragonSwitch: UISwitch!
    
    var fireValue = 0;
    var waterValue = 0;
    var iceValue = 0;
    var thunderValue = 0;
    var dragonValue = 0;
    
    var arrayToPass2 = Array(repeating: 0, count: 5)
    
    @IBAction func fireFlag(_ sender: AnyObject) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(fireSwitch.isOn==true)
        {
            print("good")
            fireValue = 1
            print(fireValue)
            arrayToPass2[0] = fireValue
        }
        else{
            print("bad")
            fireValue = 0
            print(fireValue)
            arrayToPass2[0] = fireValue
        }
        appDelegate.filterTwoArr = arrayToPass2
    }
    @IBAction func waterFlag(_ sender: AnyObject) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(waterSwitch.isOn==true)
        {
            print("good")
            waterValue = 1
            print(waterValue)
            arrayToPass2[1] = waterValue
        }
        else{
            print("bad")
            waterValue = 0
            print(waterValue)
            arrayToPass2[1] = waterValue
        }
        appDelegate.filterTwoArr = arrayToPass2
        
    }
    @IBAction func iceFlag(_ sender: AnyObject) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(iceSwitch.isOn==true)
        {
            print("good")
            iceValue = 1
            print(iceValue)
            arrayToPass2[2] = iceValue
            
        }
        else{
            print("bad")
            iceValue = 0
            print(iceValue)
            arrayToPass2[2] = iceValue
        }
        appDelegate.filterTwoArr = arrayToPass2
        
    }
    @IBAction func thunderFlag(_ sender: AnyObject) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(thunderSwitch.isOn==true)
        {
            print("good")
            thunderValue = 1
            print(thunderValue)
            arrayToPass2[3] = thunderValue
        }
        else{
            print("bad")
            thunderValue = 0
            print(thunderValue)
            arrayToPass2[3] = thunderValue
        }
        appDelegate.filterTwoArr = arrayToPass2
        
    }
    @IBAction func dragonFlag(_ sender: AnyObject) {
        print(arrayToPass2)
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(dragonSwitch.isOn==true)
        {
            print("good")
            dragonValue = 1
            print(dragonValue)
            arrayToPass2[4] = dragonValue
        }
        else{
            print("bad")
            dragonValue = 0
            print(dragonValue)
            arrayToPass2[4] = dragonValue
        }
        appDelegate.filterTwoArr = arrayToPass2
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        elementLabel.textAlignment = NSTextAlignment.center;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
