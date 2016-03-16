//
//  AppDelegate.swift
//  DetectedWifi
//
//  Created by Dang Thanh Than on 3/8/16.
//  Copyright © 2016 Than Dang. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork

//To replace Captive Network deprecase on iOS 9
import NetworkExtension.NEHotspotHelper
import NetworkExtension

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create reachability")
            return true
        }
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "reachabilityChanged:",
            name: ReachabilityChangedNotification,
            object: reachability)
        do {
            try reachability.startNotifier()
            
        } catch {
            print("Cound not start reachability notifier")
        }
        
        
        return true
    }
    
    func reachabilityChanged(notification: NSNotification) {
        let reachability = notification.object as! Reachability
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
//                let currentSSID: String = self.getSSID()
                
                print("Reachable via wifi")
            }
        } else {
            print("Not reachable")
        }
    }
    
    func getSSID() -> String {
        var currentSSID = ""

        
        if self.SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("9.0") {
//        if #available(iOS 9, OSX 10.10, *) {
            let interfaces = NEHotspotHelper.supportedNetworkInterfaces()
            print("--- \(interfaces)") // Appleの許可が得られるまで、常に空
            
            for interface in interfaces as! [NEHotspotNetwork] {
                print("--- \(interfaces)")
                let ssid = interface.SSID
                let bssid = interface.BSSID
                let secure = interface.secure
                let autoJoined = interface.autoJoined
                let signalStrength = interface.signalStrength
                currentSSID = ssid;
                print("ssid: \(ssid)")
                print("bssid: \(bssid)")
                print("secure: \(secure)")
                print("autoJoined: \(autoJoined)")
                print("signalStrength: \(signalStrength)")
            }
        } else {
//            let interfaces = CNCopySupportedInterfaces()
//            if interfaces != nil {
////                let interfacesArray = interfaces.takeRetain
//            }
        }
        
        return currentSSID
    }
    
    func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: String) -> Bool {
        return UIDevice.currentDevice().systemVersion.compare(version,
            options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
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

