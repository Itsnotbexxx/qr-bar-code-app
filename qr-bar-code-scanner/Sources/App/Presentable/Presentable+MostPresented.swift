import UIKit

extension Presentable {
    
    var mostTopPresented: UIViewController? {
        var presented = toPresent()
        while let last = presented?.presentedViewController {
            presented = last
        }
        return presented
    }
}
