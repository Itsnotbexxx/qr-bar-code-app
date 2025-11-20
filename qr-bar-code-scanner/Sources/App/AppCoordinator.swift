import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private var isOnboardingShown: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isOnboardingShown")
        } set {
            UserDefaults.standard.set(true, forKey: "isOnboardingShown")
        }
    }
    
    override func start() {
        isOnboardingShown ? runTabbar() : runOnboardingFlow()
    }
}

private extension AppCoordinator {
    func runOnboardingFlow() {
        let coordinator = OnboardingCoordinator()
        coordinator.completion = { [weak self] in
            self?.isOnboardingShown = true
            self?.runTabbar()
        }
        coordinator.start()
        router.setRootModule(coordinator)
    }
    
    func runTabbar() {
        let tabbar = TabbarViewController()
        tabbar.viewControllers = [
            makeHistory(),
            makeScanner(),
            makeSettings()
        ]
        tabbar.selectedIndex = 1
        router.setRootModule(tabbar)
    }
    
    func makeHistory() -> HistoryCoordinator {
        let coordinator = HistoryCoordinator()
        coordinator.start()
        coordinator.tabBarItem = .init(
            title: nil,
            image: nil,
            tag: 0
        )
        return coordinator
    }
    
    func makeScanner() -> ScannerPageCoordinator {
        let coordinator = ScannerPageCoordinator()
        coordinator.start()
        coordinator.tabBarItem = .init(
            title: nil,
            image: nil,
            tag: 1
        )
        return coordinator
    }
    
    func makeSettings() -> SettingsCoordinator {
        let coordinator = SettingsCoordinator()
        coordinator.start()
        coordinator.tabBarItem = .init(
            title: nil,
            image: nil,
            tag: 2
        )
        return coordinator
    }
}
