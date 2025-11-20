import Combine
import SwiftUI

@MainActor
protocol HistoryListViewModelProtocol: ObservableObject {
    var resultSubject: PassthroughSubject<HistoryList.Result, Never> { get }
    var viewState: HistoryListViewModel.ViewState { get set }
    var historyList: [HistoryModel] { get set }
    var isEdit: Bool { get set }
    var showAlert: Bool { get set }
    var selectedHistory: HistoryModel? { get set }
    
    func removeSeletedHistory()
}

final class HistoryListViewModel: HistoryListViewModelProtocol, HistoryList.Output {
    enum ViewState: Sendable {
        case empty
        case content
    }
    
    private(set) var resultSubject = PassthroughSubject<HistoryList.Result, Never>()
    @Published var viewState: ViewState = .content
    @Published var historyList: [HistoryModel] = [
        .init(
            title: "linkly.app/item/90731218192434811111",
            type: .qr,
            date: Date(),
            image: "qrCode",
            titleType: .link
        ),
        .init(
            title: "hello@google.com",
            type: .qr,
            date: Date(),
            image: "qrCode",
            titleType: .mail
        ),
        .init(
            title: "+12025550123",
            type: .qr,
            date: Date(),
            image: "qrCode",
            titleType: .phone
        ),
        .init(
            title: "SMS: hello, to: +12025550123",
            type: .qr,
            date: Date(),
            image: "qrCode",
            titleType: .text
        )
    ]
    @Published var isEdit: Bool = false
    @Published var showAlert: Bool = false
    @Published var selectedHistory: HistoryModel?
    
    func removeSeletedHistory() {
        guard let selectedHistory else { return }
        guard let index = historyList.firstIndex(where: { $0.id == selectedHistory.id }) else { return }
        historyList.remove(at: index)
    }
}
