import Foundation
import Combine

final class OnboardingCoordinator: BaseNavigationCoordinator {
    private var cancellables: Set<AnyCancellable> = []
    
    var completion: Completion?
    
    override func start() {
        runOnboarding()
    }
}

private extension OnboardingCoordinator {
    
    func runOnboarding() {
        let feature = Onboarding.Fabric.makeOnboading()
        
        feature.output.resultSubject.sink { [weak self] result in
            switch result {
            case .onTapContinue:
                self?.runPayroll()
            }
        }.store(in: &cancellables)
        
        router.setRootModule(feature.viewController)
    }
    
    func runPayroll() {
        let feature = Payroll.Fabric.makePayroll()
        
        feature.output.resultSubject.sink { [weak self] result in
            switch result {
            case .onTapContinue:
                self?.completion?()
            }
        }.store(in: &cancellables)
        
        router.push(feature.viewController)
    }
}
