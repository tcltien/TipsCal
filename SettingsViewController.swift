//
//  SettingsViewController.swift
//  TipsCal
//
//  Created by Le Huynh Anh Tien on 6/21/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var backgroundSwitch: UISwitch!
   
    @IBOutlet weak var sliderPercenLabel: UILabel!
    @IBOutlet weak var sliderPercenBar: UISlider!
    
    let step: Float = 1
    let defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        tipControl.selectedSegmentIndex = defaults.integerForKey("percent")
        backgroundSwitch.on = defaults.boolForKey("bg")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tipControlChange(sender: AnyObject) {
        defaults.setInteger(self.tipControl.selectedSegmentIndex, forKey: "percent")
        defaults.synchronize()
       
    }
    
    @IBAction func backgroundSwitchChange(sender: AnyObject) {
        print(self.backgroundSwitch.on)
        defaults.setBool(self.backgroundSwitch.on, forKey: "bg")
        defaults.synchronize()
    }
    
    
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
