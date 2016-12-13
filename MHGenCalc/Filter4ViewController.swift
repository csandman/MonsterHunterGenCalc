//
//  Filter4ViewController.swift
//  MHGenCalc
//
//  Created by Student on 12/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class Filter4ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var minValueField: UITextField!
    @IBOutlet weak var maxValueField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defenseLabel.textAlignment = NSTextAlignment.center;
        
    }
    @IBAction func applyAndSearch(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.shouldPerformAdvSearch = true
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func checkValue(_ sender: Any) {
        
        var minValueInt = Int(minValueField.text!)
        var maxValueInt = Int(maxValueField.text!)
        
        //if both fields are empty, make them default to 1 and 100
        if (minValueField.text!.isEmpty && maxValueField.text!.isEmpty)
        {
            minValueInt = 1
            maxValueInt = 100
            //print label jut to test, if it prints it works
            resultLabel.text = String(minValueInt! + maxValueInt!)
        }
        //if only one is empty
        else if (minValueField.text!.isEmpty)
        {
            minValueInt = 1
            resultLabel.text = String(minValueInt! + maxValueInt!)
        }
        else if (maxValueField.text!.isEmpty)
        {
            maxValueInt = 100
            resultLabel.text = String(minValueInt! + maxValueInt!)
        }
        
        //otherwise, if the numbers are out of range, alerts them
        else if (minValueInt! < 1 || minValueInt! > 100)
        {
            let alertController = UIAlertController(title: "Error", message: "Min value must be between 1 and 100.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if (maxValueInt! < minValueInt! || maxValueInt! > 100)
        {
            let alertController = UIAlertController(title: "Error", message: "Max value must be between min value and 100.", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        //if it says sick, then you good
        else
        {
            resultLabel.text = String(minValueInt! + maxValueInt!)
        }
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
