import UIKit

class BaseCoordinator: UIViewController, Coordinator {
    
    var tabBarItemObserver: NSKeyValueObservation?
    
    let router: Routable
    
    override var tabBarItem: UITabBarItem! {
        get {
            router.toPresent()?.tabBarItem ?? super.tabBarItem
        } set {
            router.toPresent()?.tabBarItem = newValue
        }
    }
    
    override var childForStatusBarStyle: UIViewController? {
        router.toPresent()
    }
    
    override var childForHomeIndicatorAutoHidden: UIViewController? {
        router.toPresent()
    }
    
    override var childForStatusBarHidden: UIViewController? {
        router.toPresent()
    }
    
    override var childForScreenEdgesDeferringSystemGestures: UIViewController? {
        router.toPresent()
    }
    
    override var childViewControllerForPointerLock: UIViewController? {
        router.toPresent()
    }
    
    override var transitionCoordinator: UIViewControllerTransitionCoordinator? {
        router.toPresent()?.transitionCoordinator
    }
    
    init(router: Routable) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        tabBarItemObserver?.invalidate()
        tabBarItemObserver = nil
    }
    
    func start() {
        fatalError("Implement 'start' method in \(self.self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRouterAsChild()
    }
    
    private func addRouterAsChild() {
        guard let routerViewController = router.toPresent() else { return }

        routerViewController.willMove(toParent: self)
        addChild(routerViewController)

        let childView = routerViewController.view!
        childView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childView)

        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: view.topAnchor),
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        routerViewController.didMove(toParent: self)

        tabBarItemObserver?.invalidate()
        tabBarItemObserver = routerViewController.observe(
            \.tabBarItem,
            options: [.initial, .new]
        ) { [weak self] _, change in
            self?.tabBarItem = change.newValue
        }
    }
}
