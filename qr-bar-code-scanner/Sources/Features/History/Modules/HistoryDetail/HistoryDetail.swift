import Combine

enum HistoryDetail {
    struct Input {
        let model: HistoryModel
        
        init(model: HistoryModel) {
            self.model = model
        }
    }
    
    enum Result: Sendable {
        case onTapContinue
    }
    
    @MainActor
    protocol Output {
        var resultSubject: PassthroughSubject<Result, Never> { get }
    }
    
    enum Fabric {
        
        @MainActor
        static func makeHistoryDetail(input: Input) -> (viewController: BaseViewController, output: Output) {
            let viewModel = HistoryDetailViewModel(history: input.model)
            
            let viewController = HistoryDetailViewController(
                viewModel: viewModel,
                viewBuilder: { HistoryDetailView(viewModel: viewModel) }
            )
            
            return (viewController, viewModel)
        }
    }
}
