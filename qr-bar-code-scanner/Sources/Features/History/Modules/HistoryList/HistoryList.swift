import Combine

enum HistoryList {
    enum Result: Sendable {
        case onTapContinue(model: HistoryModel)
    }
    
    @MainActor
    protocol Output {
        var resultSubject: PassthroughSubject<Result, Never> { get }
    }
    
    enum Fabric {
        
        @MainActor
        static func makeHistoryList() -> (viewController: BaseViewController, output: Output) {
            let viewModel = HistoryListViewModel()
            
            let viewController = HistoryListViewController(
                viewModel: viewModel,
                viewBuilder: { HistoryListView(viewModel: viewModel) }
            )
            
            return (viewController, viewModel)
        }
    }
}
