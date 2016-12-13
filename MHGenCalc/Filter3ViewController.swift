//
//  Filter3ViewController.swift
//  MHGenCalc
//
//  Created by Student on 12/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class Filter3ViewController: UIViewController {

    @IBOutlet weak var hunterLabel: UILabel!
    

    @IBOutlet weak var bladeSwitch: UISwitch!
    
    @IBOutlet weak var gunnerSwitch: UISwitch!
    
    var bladeValue = 0;
    var gunnerValue = 0;
    
    var arrayToPass3 = Array(repeating: 0, count: 2)

    
    @IBAction func bladeFlag(_ sender: AnyObject) {
        let appDelegate =
        UIApplication.shared.delegate as! AppDelegate
        if(bladeSwitch.isOn==true)
        {
            print("good")
            bladeValue = 1
            print(bladeValue)
            arrayToPass3[0] = bladeValue
        }
        else{
            print("bad")
            bladeValue = 0
            print(bladeValue)
            arrayToPass3[0] = bladeValue
        }
        appDelegate.filterThreeArr = arrayToPass3
        
    }
    @IBAction func gunnerFlag(_ sender: Any) {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        if(gunnerSwitch.isOn==true)
        {
            print("good")
            gunnerValue = 1
            print(gunnerValue)
            arrayToPass3[1] = gunnerValue
        }
        else{
            print("bad")
            gunnerValue = 0
            print(gunnerValue)
            arrayToPass3[1] = gunnerValue
        }
        appDelegate.filterThreeArr = arrayToPass3
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hunterLabel.textAlignment = NSTextAlignment.center;

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
