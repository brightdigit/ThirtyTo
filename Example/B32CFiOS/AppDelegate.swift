//
//  AppDelegate.swift
//  B32CFiOS
//
//  Created by Leo Dion on 12/19/19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let viewController = IdentifierDataTypeTableViewController()
    let navigationViewController = UINavigationController(rootViewController: viewController)
    let window = UIWindow.init(frame: UIScreen.main.bounds)
    window.rootViewController = navigationViewController
    window.makeKeyAndVisible()
    self.window = window
    return true
  }

  // MARK: UISceneSession Lifecycle


}

