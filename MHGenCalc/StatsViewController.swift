//
//  StatsViewController.swift
//  MHGenCalc
//
//  Created by Student on 12/8/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    @IBOutlet weak var defenseLabel: UILabel!
    
    @IBOutlet weak var totalDefenseLabel: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    
    @IBOutlet weak var thunderLabel: UILabel!
    
    
    @IBOutlet weak var dragonLabel: UILabel!
    
    @IBOutlet weak var fireLabel: UILabel!
    
    @IBOutlet weak var waterLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let stats = appDelegate.totalStats(build: appDelegate.currentSetArr[0])

        totalDefenseLabel.text = String(stats["max_defense"]!)
        defenseLabel.text = String(stats["defense"]!)
        iceLabel.text = String(stats["ice_res"]!)
        thunderLabel.text = String(stats["thunder_res"]!)
        dragonLabel.text = String(stats["dragon_res"]!)
        fireLabel.text = String(stats["fire_res"]!)
        waterLabel.text = String(stats["water_res"]!)
        
        
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
