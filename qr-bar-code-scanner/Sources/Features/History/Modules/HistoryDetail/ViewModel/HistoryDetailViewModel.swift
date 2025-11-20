import Combine
import SwiftUI

@MainActor
protocol HistoryDetailViewModelProtocol: ObservableObject {
    var resultSubject: PassthroughSubject<HistoryDetail.Result, Never> { get }
    var history: HistoryModel { get set }
}

final class HistoryDetailViewModel: HistoryDetailViewModelProtocol, HistoryDetail.Output {
    private(set) var resultSubject = PassthroughSubject<HistoryDetail.Result, Never>()
    @Published var history: HistoryModel
    
    init(history: HistoryModel) {
        self.history = history
    }
}
