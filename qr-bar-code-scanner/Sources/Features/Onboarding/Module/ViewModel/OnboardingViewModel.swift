import SwiftUI
import Combine

@MainActor
protocol OnboardingViewModelProtocol: ObservableObject {
    var resultSubject: PassthroughSubject<Onboarding.Result, Never> { get }

    var mode: OnboardingViewModel.OnboardingMode { get set }
    
    func onTapNext()
}

final class OnboardingViewModel: OnboardingViewModelProtocol, Onboarding.Output {
    
    enum OnboardingMode: Int, CaseIterable {
        case first
        case second
        case third
        
        var backgroundImageName: String {
            switch self {
            case .first:
                return "onboardingFirst"
            case .second:
                return "onboardingSecond"
            case .third:
                return "onboardingThird"
            }
        }
        
        var title: String {
            switch self {
            case .first:
                return "Scan any barcodes and QR"
            case .second:
                return "Your feedback helps us grow"
            case .third:
                return "More than just scanning"
            }
        }
        
        var subtitle: String {
            switch self {
            case .first:
                return "Instantly scan barcodes and QR codes — access anything with a single tap"
            case .second:
                return "Tell us what works — it helps us grow and improve"
            case .third:
                return "Access your full scan history and share results easily"
            }
        }
    }
        
    @Published var mode: OnboardingMode = .first
    
    private(set) var resultSubject = PassthroughSubject<Onboarding.Result, Never>()
    
    
    func onTapNext() {
        switch mode {
        case .first:
            mode = .second
        case .second:
            mode = .third
        case .third:
            resultSubject.send(.onTapContinue)
        }
    }
}
