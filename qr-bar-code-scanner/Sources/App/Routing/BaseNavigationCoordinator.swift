import UIKit

class BaseNavigationCoordinator: AppNavigationController, Coordinator {
    
    var router: Routable { self }
    
    func start() {
        fatalError("Implement 'start' method in \(self.self)")
    }
}
