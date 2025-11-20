import Combine

enum SettingsLimit {
    enum Result: Sendable {
        case onTapContinue
    }
    
    @MainActor
    protocol Output {
        var resultSubject: PassthroughSubject<Result, Never> { get }
    }
    
    enum Fabric {
        @MainActor
        static func makeSettingsLimit() -> (viewController: BaseViewController, output: Output) {
            let viewModel = SettingsLimitViewModel()
            
            let viewController = SettingsLimitViewController(
                viewModel: viewModel,
                viewBuilder: { SettingsLimitView(viewModel: viewModel) }
            )
            
            return (viewController, viewModel)
        }
    }
}
