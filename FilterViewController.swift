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
