import SwiftUI
import Combine

protocol SettingsLimitViewModelProtocol: ObservableObject {
    var resultSubject: PassthroughSubject<SettingsLimit.Result, Never> { get }
}

final class SettingsLimitViewModel: SettingsLimitViewModelProtocol, SettingsLimit.Output {
    private(set) var resultSubject = PassthroughSubject<SettingsLimit.Result, Never>()
}
