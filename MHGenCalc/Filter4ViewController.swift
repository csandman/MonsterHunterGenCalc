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
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defenseLabel.textAlignment = NSTextAlignment.center;
        
    }

    @IBAction func resultDisplay(_ sender: Any) {
        resultLabel.text = minValueField.text
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
