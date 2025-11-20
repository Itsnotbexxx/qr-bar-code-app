import Combine

enum Payroll {
    enum Result: Sendable {
        case onTapContinue
    }
    
    @MainActor
    protocol Output {
        var resultSubject: PassthroughSubject<Result, Never> { get }
    }
    
    enum Fabric {
        
        @MainActor
        static func makePayroll() -> (viewController: BaseViewController, output: Output) {
            let viewModel = PayrollViewModel()
            
            let viewController = PayrollViewController(
                viewModel: viewModel,
                viewBuilder: { PayrollView(viewModel: viewModel) }
            )
            
            return (viewController, viewModel)
        }
    }
}
