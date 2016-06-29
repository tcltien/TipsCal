//
//  AppDelegate.swift
//  TipsCal
//
//  Created by Le Huynh Anh Tien on 6/19/16.
//  Copyright © 2016 Tien Le. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaults = NSUserDefaults.standardUserDefaults()
    var vc = ViewController()
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        print("will lauching option")
        print(launchOptions)
        return true
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.useLastValue()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        self.setLastValue()
        print("Regisn Active")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("Did Enter Background")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print("foreground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("Did Become Active")
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("will Terminate")
    }

    
    func useLastValue() {
        self.defaults = NSUserDefaults.standardUserDefaults()
        let lastMin = self.defaults.doubleForKey("lastMin")
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        let components = cal.components(.Minute ,fromDate: date)
        let beginMin = Double(components.minute)
        NSLog("use Last value \(date) ")
        print(components.minute)
        print(lastMin)
        // if user close app more than 10 minutes, bill amount will change to 0
        if beginMin - lastMin >= 10 || beginMin - lastMin < 0 {
            self.defaults.setValue(0, forKeyPath: "bill")
        }
        self.defaults.synchronize()
    }
    
    func setLastValue() {
        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        let components = cal.components(.Minute ,fromDate: date)
        self.defaults.setDouble(Double(components.minute), forKey: "lastMin")
        self.defaults.synchronize()
    }
}

