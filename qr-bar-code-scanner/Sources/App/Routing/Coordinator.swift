protocol Coordinator: AnyObject, Presentable {
    
    var router: Routable { get }
    
    func start()
}
