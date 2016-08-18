//
//  AppDelegate.swift
//  Photorama
//
//  Created by Xavi Moll on 18/08/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let rootViewController = window!.rootViewController as! UINavigationController
        let photosViewController = rootViewController.topViewController! as! PhotosViewController
        photosViewController.store = PhotoStore()
        
        return true
    }

}

