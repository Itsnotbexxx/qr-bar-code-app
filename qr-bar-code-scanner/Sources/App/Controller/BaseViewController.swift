import UIKit
import SwiftUI

protocol BaseViewControllerProtocol: UIViewController {
    @MainActor var activityIndicator: UIActivityIndicatorView { get }
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        activityIndicator.color = UIColor.black
        
        return activityIndicator
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    public func add<Content: SwiftUI.View>(_ swiftUIView: Content) {
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
