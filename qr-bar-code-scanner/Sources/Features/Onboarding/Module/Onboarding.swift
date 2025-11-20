import Combine

enum Onboarding {
    enum Result: Sendable {
        case onTapContinue
    }
    
    @MainActor
    protocol Output {
        var resultSubject: PassthroughSubject<Result, Never> { get }
    }
    
    enum Fabric {
        
        @MainActor
        static func makeOnboading() -> (viewController: BaseViewController, output: Output) {
            let viewModel = OnboardingViewModel()
            
            let viewController = OnboardingViewController(
                viewModel: viewModel,
                viewBuilder: { OnboardingView(viewModel: viewModel) }
            )
            
            return (viewController, viewModel)
        }
    }
}
