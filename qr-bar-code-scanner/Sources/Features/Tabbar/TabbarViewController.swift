import SwiftUI
import Combine

public protocol InlineConfigurable {}

extension NSObject: InlineConfigurable {}

public extension InlineConfigurable {
    @discardableResult
    func apply(_ configurator: (Self) -> Void) -> Self {
        configurator(self)
        return self
    }
}


final public class RestrictedUIHostingController<Content>: UIHostingController<Content> where Content: View {

    /// The hosting controller may in some cases want to make the navigation bar be not hidden.
    /// Restrict the access to the outside world, by setting the navigation controller to nil when internally accessed.
    public override var navigationController: UINavigationController? {
        nil
    }
}

extension View {
    public func bridge() -> UIHostingController<Self> {
        RestrictedUIHostingController(rootView: self).apply { vc in
            vc.view.backgroundColor = .clear
        }
    }
}

final class TabbarViewController: UITabBarController, Routable {
    let viewModel = TabbarViewModel()
    
    var tabbarView: UIView!
    
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupView()
    }
    
    private func setupView() {
        tabbarView = TabbarView(
            viewModel: self.viewModel,
            onTapButton: { [weak self] in
                guard let self else { return }
                self.selectedIndex = self.viewModel.selectedType.rawValue
            }
        ).bridge().view
        tabbarView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tabbarView)
        
        NSLayoutConstraint.activate([
            tabbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabbarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
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
      
        selectedIndex = viewModel.selectedType.rawValue
    }
    
    public func setRootModule(_ module: Presentable?, animated: Bool) {
      fatalError("Should be configured")
    }
    
    public func push(_ module: Presentable?, animated: Bool) {
      fatalError("Should be configured")
    }
    
    public func popModule(animated: Bool) {
      fatalError("Should be configured")
    }
    
    public func popToRootModule(animated: Bool) {
      fatalError("Should be configured")
    }
    
    public func removeModule(_ module: Presentable?) {
      fatalError("Should be configured")
    }
    
    func popModule(animated: Bool, completion: Completion?) {
        fatalError("Should be configured")
    }
}
