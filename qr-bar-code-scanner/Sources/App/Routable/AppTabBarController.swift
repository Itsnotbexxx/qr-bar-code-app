import UIKit

public class AppTabBarController: UITabBarController, Routable {
    
    var onUnauthorizedCompletion: Completion?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppeareance()
        delegate = self
    }
    
    public func present(_ module: Presentable?, animated: Bool, completion: Completion?) {
        guard let controllerToPresent = module?.toPresent() else { return }
        let presenter: UIViewController = mostTopPresented ?? self
        presenter.present(controllerToPresent, animated: animated, completion: completion)
    }
    
    public func dismissModule(animated: Bool, completion: Completion?) {
        dismiss(animated: animated, completion: completion)
    }
    
    public func setModules(_ modules: [Presentable?], animated: Bool) {
        setViewControllers(modules.compactMap { $0?.toPresent() }, animated: false)
    }
    
    public func showModule(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        guard let indexToSelect = viewControllers?.firstIndex(where: { $0 == controller }) else { return }
        
        selectedIndex = indexToSelect
    }
    
    public func setRootModule(_ module: Presentable?, animated: Bool) {
        fatalError("Should be configured")
    }
    
    public func push(_ module: Presentable?, animated: Bool) {
        fatalError("Should be configured")
    }
    
    public func popModule(animated: Bool, completion: Completion?) {
        fatalError("Should be configured")
    }
    
    public func popToRootModule(animated: Bool) {
        fatalError("Should be configured")
    }
    
    public func removeModule(_ module: Presentable?) {
        fatalError("Should be configured")
    }
}

extension AppTabBarController {
    
    private func configureAppeareance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = ResourcesAsset.blackGrey.color

        appearance.compactInlineLayoutAppearance.selected.iconColor = ResourcesAsset.green.color
        appearance.compactInlineLayoutAppearance.normal.iconColor = ResourcesAsset.white.color
        
        appearance.inlineLayoutAppearance.selected.iconColor = ResourcesAsset.green.color
        appearance.inlineLayoutAppearance.normal.iconColor = ResourcesAsset.white.color
        
        appearance.stackedLayoutAppearance.selected.iconColor = ResourcesAsset.green.color
        appearance.stackedLayoutAppearance.normal.iconColor = ResourcesAsset.white.color
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

extension AppTabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
