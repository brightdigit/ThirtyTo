import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    let viewController = IdentifierDataTypeTableViewController()
    let navigationViewController = UINavigationController(rootViewController: viewController)
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = navigationViewController
    window.makeKeyAndVisible()
    self.window = window
    return true
  }

  // MARK: UISceneSession Lifecycle
}
