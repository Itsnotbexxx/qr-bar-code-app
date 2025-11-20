import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupNavigation()

        return true
    }
    
    private func setupNavigation() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let router = AppRouter()
        appCoordinator = AppCoordinator(router: router)
        appCoordinator?.start()
        
        window?.rootViewController = appCoordinator
        window?.makeKeyAndVisible()
    }
}

