import SwiftUI
import Combine

protocol SettingsViewModelProtocol: ObservableObject {
    var resultSubject: PassthroughSubject<Settings.Result, Never> { get }

}

final class SettingsViewModel: SettingsViewModelProtocol, Settings.Output {
    private(set) var resultSubject = PassthroughSubject<Settings.Result, Never>()
}
