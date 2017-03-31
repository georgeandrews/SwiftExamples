//
//  AppDelegate.swift
//  ConnectWithMe
//
//  Created by George Andrews on 3/31/17.
//  Copyright © 2017 George Andrews. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var dataController: CWMDataController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // Override point for customization after application launch.
    dataController = CWMDataController()
    
    guard let navController = window?.rootViewController as? UINavigationController else {
      fatalError("Root view controller is not a navigation controller")
    }
    guard let controller = navController.topViewController as? ConnectViewController else {
      fatalError("Top view controller is not a master view controller: \(navController.topViewController.self)")
    }
    
    controller.managedObjectContext = dataController?.mainContext
    
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    dataController?.saveContext()
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    dataController?.saveContext()
  }

  func applicationWillTerminate(_ application: UIApplication) {
    dataController?.saveContext()  }
  
  func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
    return true
  }
  
  func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
    return true
  }

}

