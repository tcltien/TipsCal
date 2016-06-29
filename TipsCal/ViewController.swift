//
//  ViewController.swift
//  TipsCal
//
//  Created by Le Huynh Anh Tien on 6/19/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    
    @IBOutlet weak var validLabel: UILabel!
    
    @IBOutlet weak var buttonPercent: UIButton!
    var defaults = NSUserDefaults.standardUserDefaults()
    var loca  = NSLocale.currentLocale().localeIdentifier
    var currency = ""
    var chkTime = NSDate()
    var durationMin = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billField.becomeFirstResponder()
        let tmp = defaults.doubleForKey("bill")
        if  tmp == 0 {
            billField.attributedPlaceholder = NSAttributedString(string: currency)
        } else {
            billField.text = String(format: "%.f", defaults.doubleForKey("bill"))
        }
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        checkCurrency(loca)
        // handle when enter app in background
        [NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reinstateBackgroundTask), name: UIApplicationDidBecomeActiveNotification, object: nil)]
                
    }

    @IBAction func buttonClick(sender: AnyObject) {
        let mapViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(mapViewControllerObj, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func onEditingChange(sender: AnyObject) {
        getTipsAmount(getPercent())
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDetails.center.x -= self.viewDetails.bounds.width
        UIView.animateWithDuration(0.5, animations: {
            self.viewDetails.center.x += self.viewDetails.bounds.width
        })
        if let bg:Bool? = defaults.boolForKey("bg") {
            changeDarkBackground(bg!)
        }
        
        getTipsAmount(getPercent())
       
    }
  
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Did Appear2")
       
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view Will  DISAPPEAR")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let billValue = NSString(string: billField.text!).doubleValue
        defaults.setDouble(billValue, forKey: "bill")
    
        print("view Did Disappear")
    }
    
    
    // function handle when app re-open
    func reinstateBackgroundTask() {
        loca  = NSLocale.currentLocale().localeIdentifier
        defaults = NSUserDefaults.standardUserDefaults()
        let bill = defaults.doubleForKey("bill")
        if (bill > 0) {
            billField.text = String(format: "%d", Int(bill))
        } else {
            billField.text = ""
        }
        
        checkCurrency(loca)
        getTipsAmount(getPercent())
        
    }
    
    /*
     * Function check currency by current locale
     */
    func checkCurrency(loca:String) {
        if ( loca == "en_GB"){
            currency = "€"
        } else {
            currency = "$"
        }
    }
    
    /*
     * Function is use for get tip percent
     *
     */
    func getPercent() -> Double {
        
        let intValue = defaults.integerForKey("percent")
        var tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[intValue]
        buttonPercent.setTitle(String(Int(tipPercentage * 100)) + "%"
            , forState: UIControlState.Normal)
        return tipPercentage
    }
    
    /*
     * Function is use for calculate tip and shown it on
     *
     */
    func getTipsAmount(tipPercentage:Double) -> Double {
        
        var total:Double = 0.0
        let billAmount = billField.text! as NSString
        
        if  Double(billAmount as String) != nil {
            let tip = Double(billAmount.doubleValue) * tipPercentage
            total = Double(billAmount.doubleValue) + tip
            
            tipLabel.text = String(format: "\(currency) %.2f",  tip)
            totalLabel.text = String(format: "\(currency) %.2f", total)
            validLabel.text = ""
        } else {
            
            billField.attributedPlaceholder = NSAttributedString(string: currency)
            tipLabel.text = "\(currency)0.00"
            totalLabel.text = "\(currency)0.00"
            validLabel.text = "Invalid Input!"
            validLabel.textColor = UIColor.redColor()
            
            if (billAmount  == "") {
                validLabel.text = ""
                validLabel.textColor = UIColor.whiteColor()
            }
            
            return 0;
        }
        let billValue = NSString(string: billField.text!).doubleValue
        defaults.setDouble(billValue, forKey: "bill")
        return total
       
    }
    
    // function change dark background
    func changeDarkBackground(bg:Bool) {
        if bg {
            self.billField.backgroundColor = UIColor.clearColor()
            self.viewDetails.backgroundColor = UIColor.clearColor()
        } else {
            self.billField.backgroundColor = UIColor(red: 0.5, green: 1, blue: 1, alpha: 0.5)
            self.viewDetails.backgroundColor = UIColor(red: 0.5, green: 1, blue: 1, alpha: 0.5)
        }
    }
}

