import SwiftUI
import Combine

protocol PayrollViewModelProtocol: ObservableObject {
    var resultSubject: PassthroughSubject<Payroll.Result, Never> { get }
}

final class PayrollViewModel: PayrollViewModelProtocol, Payroll.Output {
    private(set) var resultSubject = PassthroughSubject<Payroll.Result, Never>()
}
