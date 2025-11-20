import UIKit

final class AppRouter: UIViewController, Routable {
    
    private var rootViewController: UIViewController? {
        willSet {
            rootViewController?.willMove(toParent: nil)
            rootViewController?.view.removeFromSuperview()
            rootViewController?.removeFromParent()
            rootViewController?.didMove(toParent: nil)
        } didSet {
            guard let rootVC = rootViewController else { return }
            rootVC.willMove(toParent: self)
            addChild(rootVC)
            let childView = rootVC.view!
            childView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(childView)

            NSLayoutConstraint.activate([
                childView.topAnchor.constraint(equalTo: view.topAnchor),
                childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                childView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            rootVC.didMove(toParent: self)
        }
    }
    
    public func present(_ module: Presentable?, animated: Bool, completion: Completion?) {
        guard let controllerToPresent = module?.toPresent() else { return }
        let presenter: UIViewController = mostTopPresented ?? self
        presenter.present(controllerToPresent, animated: animated, completion: completion)
    }
    
    public func dismissModule(animated: Bool, completion: Completion?) {
        dismiss(animated: animated, completion: completion)
    }
    
    public func setRootModule(_ module: Presentable?, animated: Bool) {
        rootViewController = module?.toPresent()
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
    
    public func setModules(_ modules: [Presentable?], animated: Bool) {
        fatalError("Should be configured")
    }
    
    public func showModule(_ module: Presentable?, animated: Bool) {
        fatalError("Should be configured")
    }
}
