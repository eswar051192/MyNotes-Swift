//
//  AppDelegate.swift
//  MyNotes
//
//  Created by Eswar venigalla on 12/04/18.
//  Copyright © 2018 rawseFin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
   var setCurrentInstance = CoreDataManager.shared

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
      return true
   }

   func applicationWillResignActive(_ application: UIApplication) {}

   func applicationDidEnterBackground(_ application: UIApplication) {}

   func applicationWillEnterForeground(_ application: UIApplication) {}

   func applicationDidBecomeActive(_ application: UIApplication) {}

   func applicationWillTerminate(_ application: UIApplication) {}


}

