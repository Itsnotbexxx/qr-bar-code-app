import SwiftUI
import Combine

final class ScannerPageCoordinator: BaseNavigationCoordinator {
    private var cancellables: Set<AnyCancellable> = []
    
    override func start() {
        showScanner()
    }
}

extension ScannerPageCoordinator {
    
    private func showScanner() {
        let feature = ScannerPage.Fabric.makeScanner()
        
        feature.output.resultSubject.sink { [weak self] result in
            switch result {
            case let .showScannedDetail(model):
                self?.showDetail(model: model)
            }
        }.store(in: &cancellables)
        
        router.setRootModule(feature.viewController)
    }
    
    private func showDetail(model: HistoryModel) {
        let feature = HistoryDetail.Fabric.makeHistoryDetail(input: .init(model: model))
        
        feature.output.resultSubject.sink { [weak self] result in
            switch result {
            case .onTapContinue:
                print("onTap Continue")
            }
        }.store(in: &cancellables)
        
        router.push(feature.viewController)
    }
}
