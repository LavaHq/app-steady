//
//  AppDelegate.swift
//  app-steady
//
//  Created by Andrew Demoleas on 4/6/16.
//  Copyright © 2016 Hawt-Lava. All rights reserved.
//

import UIKit


// GLOBAL CONSTANTS
//let UUID = UIDevice.currentDevice().identifierForVendor!.UUIDString
let UUID = "jar-asdjar"
//
//let COLOR_TEXT = UIColor.init(
//    colorLiteralRed: 85.0/255.0,
//    green: 107.0/255.0,
//    blue: 120.0/255.0,
//    alpha: 1.0)
//let COLOR_BACKGROUND = UIColor.init(
//    colorLiteralRed: 245.0/255.0,
//    green: 247.0/255.0,
//    blue: 249.0/255.0,
//    alpha: 1.0)
//
//let COLOR_BORDER = UIColor.init(
//    colorLiteralRed: 167.0/255.0,
//    green: 173.0/255.0,
//    blue: 186.0/255.0,
//    alpha: 1.0)

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
    if (cString.hasPrefix("#")) {
        cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
    }
    
    if ((cString.characters.count) != 6) {
        return UIColor.grayColor()
    }
    
    var rgbValue:UInt32 = 0
    NSScanner(string: cString).scanHexInt(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


let COLOR_TEXT = hexStringToUIColor("#ffffff")
let COLOR_BACKGROUND = hexStringToUIColor("#99c05e")
let COLOR_BORDER = hexStringToUIColor("#525d40")
let COLOR_FOREGROUND = hexStringToUIColor("#28b08a")
let COLOR_BUTTON = hexStringToUIColor("#4c602f")
let COLOR_TINT = hexStringToUIColor("#89ac54")
let FONT_MEDIUM = "Avenir-Medium"

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

