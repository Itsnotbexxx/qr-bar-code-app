import SwiftUI

struct HistoryListView<ViewModel: HistoryListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        switch viewModel.viewState {
        case .empty:
            emptyView
        case .content:
            list
        }
    }
    
    private var emptyView: some View {
        VStack {
            HistoryListEmptyView()
                .padding(.top, 20)
            Spacer()
        }
        .background(Color(hex: "#DADADA"))
    }
    
    private var list: some View {
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(viewModel.historyList) { history in
                    HistoryListItemView(item: history, isEditMode: $viewModel.isEdit) {
                        viewModel.showAlert = true
                        viewModel.selectedHistory = history
                    }
                    .onTapGesture {
                        viewModel.resultSubject.send(.onTapContinue(model: history))
                    }
                        .padding(.horizontal, 16)
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Delete this item?"),
                message: Text("This action will remove it from your history"),
                primaryButton: .default(Text("Cancel")) {
                    viewModel.selectedHistory = nil
                },
                secondaryButton: .destructive(Text("Delete")) {
                    viewModel.removeSeletedHistory()
                }
            )
        }
        .background(Color(hex: "#DADADA"))
    }
}

#Preview {
    HistoryListView(viewModel: HistoryListViewModel())
}
