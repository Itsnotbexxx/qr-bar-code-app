import Combine

enum ScannerPage {
    enum Result: Sendable {
        case showScannedDetail(model: HistoryModel)
    }
    
    @MainActor
    protocol Output {
        var resultSubject: PassthroughSubject<Result, Never> { get }
    }
    
    enum Fabric {
        
        @MainActor
        static func makeScanner() -> (viewController: BaseViewController, output: Output) {
            let viewModel = ScannerViewModel()
            
            let viewController = ScannerViewController(
                viewModel: viewModel,
                viewBuilder: { ScannerView(viewModel: viewModel) }
            )
            
            return (viewController, viewModel)
        }
    }
}
