//
//  AppDelegate.swift
//  B32CFiOS
//
//  Created by Leo Dion on 12/19/19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window : UIWindow!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let viewController = ViewController()
    let window = UIWindow.init(frame: UIScreen.main.bounds)
    window.rootViewController = viewController
    window.makeKeyAndVisible()
    self.window = window
    return true
  }

  // MARK: UISceneSession Lifecycle


}

