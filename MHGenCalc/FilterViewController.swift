//
//  FilterViewController.swift
//  MHGenCalc
//
//  Created by Student on 12/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var armorLabel: UILabel!
    
    
    @IBOutlet weak var headSwitch: UISwitch!
    @IBOutlet weak var chestSwitch: UISwitch!
    @IBOutlet weak var armsSwitch: UISwitch!
    @IBOutlet weak var waistSwitch: UISwitch!
    @IBOutlet weak var legsSwitch: UISwitch!
    @IBOutlet weak var myLabel: UILabel!
    
    var headValue = 0;
    var chestValue = 0;
    var armsValue = 0;
    var waistValue = 0;
    var legsValue = 0;
    
    var arrayToPass = Array(repeating: 0, count: 5)
    
    @IBAction func headFlag(_ sender: AnyObject) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(headSwitch.isOn==true)
        {
            print("good")
         headValue = 1
            print(headValue)
            arrayToPass[0] = headValue
        }
        else{
            print("bad")
            headValue = 0
            print(headValue)
            arrayToPass[0] = headValue
        }
        appDelegate.filterOneArr = arrayToPass
    }
    @IBAction func chestFlag(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(chestSwitch.isOn==true)
        {
            print("good")
            chestValue = 1
            print(chestValue)
            arrayToPass[1] = chestValue
        }
        else{
            print("bad")
            chestValue = 0
            print(chestValue)
            arrayToPass[1] = chestValue
        }
        appDelegate.filterOneArr = arrayToPass

    }
    @IBAction func armsFlag(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(armsSwitch.isOn==true)
        {
            print("good")
            armsValue = 1
            print(armsValue)
            arrayToPass[2] = armsValue
            
        }
        else{
            print("bad")
            armsValue = 0
            print(armsValue)
            arrayToPass[2] = armsValue
        }
        appDelegate.filterOneArr = arrayToPass

    }
    @IBAction func waistFlag(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(waistSwitch.isOn==true)
        {
            print("good")
            waistValue = 1
            print(waistValue)
            arrayToPass[3] = waistValue
        }
        else{
            print("bad")
            waistValue = 0
            print(waistValue)
            arrayToPass[3] = waistValue
        }
        appDelegate.filterOneArr = arrayToPass

    }
    @IBAction func legsFlag(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(legsSwitch.isOn==true)
        {
            print("good")
            legsValue = 1
            print(legsValue)
            arrayToPass[4] = legsValue
        }
        else{
            print("bad")
            legsValue = 0
            print(legsValue)
            arrayToPass[4] = legsValue
        }
        appDelegate.filterOneArr = arrayToPass

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        armorLabel.textAlignment = NSTextAlignment.center;

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
