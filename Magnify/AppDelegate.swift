//
//  AppDelegate.swift
//  Magnify
//
//  Created by Ben Guo on 4/1/15.
//  Copyright (c) 2015 benzguo. All rights reserved.
//

import UIKit

let clientID = "1a30743a1fc14f7399e13c524193c35d"
let callbackURL = "magnifyplayer://"
let sessionUserDefaultsKey = "SpotifySession"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Set up shared authentication information
        let auth = SPTAuth.defaultInstance()
        auth.clientID = clientID;
        auth.requestedScopes = [SPTAuthStreamingScope];
        auth.redirectURL = NSURL(string: callbackURL)
//        auth.tokenSwapURL = NSURL(string: "")
//        auth.tokenRefreshURL = NSURL(string: "")
        auth.sessionUserDefaultsKey = sessionUserDefaultsKey
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

