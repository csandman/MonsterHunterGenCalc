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

