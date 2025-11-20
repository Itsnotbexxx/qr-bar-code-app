import UIKit

public protocol Presentable: UIViewController {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    
    public func toPresent() -> UIViewController? {
        return self
    }
}
