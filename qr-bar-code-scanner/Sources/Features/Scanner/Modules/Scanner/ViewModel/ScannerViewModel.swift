import SwiftUI
import Combine

protocol ScannerViewModelProtocol: ObservableObject {
    var resultSubject: PassthroughSubject<ScannerPage.Result, Never> { get }

}

final class ScannerViewModel: ScannerViewModelProtocol, ScannerPage.Output {
    private(set) var resultSubject = PassthroughSubject<ScannerPage.Result, Never>()
}

