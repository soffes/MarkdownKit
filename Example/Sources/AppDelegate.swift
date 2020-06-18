import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let window = UIWindow()
        let viewController = DemoViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
