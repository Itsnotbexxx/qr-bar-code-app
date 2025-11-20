import SwiftUI
import Combine

final class SettingsCoordinator: BaseNavigationCoordinator {
    private var cancellables: Set<AnyCancellable> = []
    
    override func start() {
        showSetting()
    }
}

extension SettingsCoordinator {
    
    private func showSetting() {
        let feature = Settings.Fabric.makeSettings()
        
        feature.output.resultSubject.sink { [weak self] result in
            switch result {
            case .onTapContinue:
                self?.showSettingsLimit()
            }
        }.store(in: &cancellables)
        
        router.setRootModule(feature.viewController)
    }
    
    private func showSettingsLimit() {
        let feature = SettingsLimit.Fabric.makeSettingsLimit()
        
        feature.output.resultSubject.sink { [weak self] result in
            switch result {
            case .onTapContinue:
                self?.showSettingsLimit()
            }
        }.store(in: &cancellables)
        
        router.push(feature.viewController)
    }
}
