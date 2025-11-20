import UIKit

class AppNavigationController: UINavigationController, Routable {
    
    private var rootController: UINavigationController {
        self
    }
    
    let appearanceConfigurator = NavigationAppearanceConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appearanceConfigurator.configure(navigationController: self)
    }
    
    public func present(_ module: Presentable?, animated: Bool, completion: Completion?) {
        guard let controllerToPresent = module?.toPresent() else { return }
        let presenter: UIViewController = mostTopPresented ?? rootController
        presenter.present(controllerToPresent, animated: animated, completion: completion)
    }
    
    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController.dismiss(animated: animated, completion: completion)
    }
    
    public func push(_ module: Presentable?, animated: Bool) {
        var moduleToPresent = module
        
        if !rootController.viewControllers.isEmpty {
            moduleToPresent = moduleToPresent?.toPresent()
        }
        
        guard let controllerToPush = moduleToPresent?.toPresent() else { return }
        controllerToPush.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: " ",
            style: .plain,
            target: nil,
            action: nil
        )
        controllerToPush.navigationItem.backButtonTitle = " "
        // Won't show the same screen
        if let topController = rootController.topViewController,
           topController === controllerToPush { return }
        
        rootController.pushViewController(controllerToPush, animated: animated)
    }
    
    public func popModule(animated: Bool, completion: Completion?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        rootController.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    public func popToRootModule(animated: Bool) {
        rootController.popToRootViewController(animated: animated)
    }
    
    public func setRootModule(_ module: Presentable?, animated: Bool) {
        guard let controllerToSet = module?.toPresent() else { return }
        rootController.setViewControllers([controllerToSet], animated: animated)
    }
    
    public func removeModule(_ module: Presentable?) {
        guard let contollerToRemove = module?.toPresent() else { return }
        rootController.viewControllers.removeAll(where: { $0 === contollerToRemove })
    }
    
    public func setModules(_ modules: [Presentable?], animated: Bool) {
        let controllers = modules.compactMap { $0?.toPresent() }
        rootController.setViewControllers(controllers, animated: animated)
    }
    
    public func showModule(_ module: Presentable?, animated: Bool) {
        guard let controllerToShow = module?.toPresent() else { return }
        rootController.popToViewController(controllerToShow, animated: animated)
    }
}

final class NavigationAppearanceConfigurator: NSObject, UIGestureRecognizerDelegate {
    
    func configure(navigationController: UINavigationController) {}
}

extension NavigationAppearanceConfigurator: UINavigationControllerDelegate {
    
    private func update(navigationBar: UINavigationBar, backgroundColor: UIColor?) {
        if #available(iOS 13, *) {
            navigationBar.compactAppearance?.backgroundColor = backgroundColor
            navigationBar.standardAppearance.backgroundColor = backgroundColor
            navigationBar.scrollEdgeAppearance?.backgroundColor = backgroundColor
        }
        
        navigationBar.barTintColor = backgroundColor
        navigationBar.backgroundColor = backgroundColor
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        navigationController.setNavigationBarHidden(viewController.barIsHidden, animated: false)
        guard animated else {
            self.update(navigationBar: navigationController.navigationBar, backgroundColor: viewController.barColor)
            return
        }
        let savedColor = navigationController.navigationBar.backgroundColor
        navigationController.transitionCoordinator?.animateAlongsideTransition(
            in: navigationController.view,
            animation: { _ in
                self.update(navigationBar: navigationController.navigationBar, backgroundColor: viewController.barColor)
            }, completion: { context in
                if context.isCancelled {
                    self.update(navigationBar: navigationController.navigationBar, backgroundColor: savedColor)
                }
            }
        )
    }
}

extension UIViewController {
    
    @objc var barColor: UIColor? { .clear }
    @objc var barIsHidden: Bool { true }
}
