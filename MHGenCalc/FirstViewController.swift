//
//  FirstViewController.swift
//  MHGenCalc
//
//  Created by Student on 11/17/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var humanPalico: UISegmentedControl!
    
    
    @IBOutlet weak var savedTable: UITableView!
    
    @IBOutlet weak var progressTable: UITableView!
    
    
    @IBOutlet weak var startBuild: UIButton!
    
    
    @IBOutlet weak var savedLabel: UITextField!
    
    
    @IBOutlet weak var progressLabel: UITextField!
    
    

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

