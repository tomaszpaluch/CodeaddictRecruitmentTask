import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController(
            rootViewController: SearchViewController(
                viewModel: .init(
                    navigationItemTitle: "Search",
                    headerViewLabelText: "Repositories"
                )
            )
        )
        window?.makeKeyAndVisible()
    
        return true
    }
}

