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
    
    @IBOutlet weak var bladeMasterSwitch: UISwitch!
    @IBOutlet weak var gunnerSwitch: UISwitch!
    
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
