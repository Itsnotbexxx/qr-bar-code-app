extension Presentable {
    
    func withDisabledLargeTitle() -> Presentable? {
        guard let controllerToPresent = toPresent() else { return nil }
        controllerToPresent.navigationItem.largeTitleDisplayMode = .never
        return controllerToPresent
    }
    
    func withHiddenBottomBar() -> Presentable? {
        toPresent()?.hidesBottomBarWhenPushed = true
        return self
    }
}
