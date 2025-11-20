import Combine

enum Settings {
    enum Result: Sendable {
        case onTapContinue
    }
    
    @MainActor
    protocol Output {
        var resultSubject: PassthroughSubject<Result, Never> { get }
    }
    
    enum Fabric {
        
        @MainActor
        static func makeSettings() -> (viewController: BaseViewController, output: Output) {
            let viewModel = SettingsViewModel()
            
            let viewController = SettingsViewController(
                viewModel: viewModel,
                viewBuilder: { SettingsView(viewModel: viewModel) }
            )
            
            return (viewController, viewModel)
        }
    }
}
