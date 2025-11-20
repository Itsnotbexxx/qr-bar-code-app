import SwiftUI

struct HistoryDetailView<ViewModel: HistoryDetailViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        content
            .background(
                   Color(hex: "#DADADA")
                       .ignoresSafeArea()
               )
    }
    
    private var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 12) {
                titleView
                buttons
                qrImgae
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
        }
    }
    
    private var titleView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.history.type.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.9))
                .padding(.horizontal, 8)
                .background(Color.white)
                .cornerRadius(99)
        }
    }
    
    @ViewBuilder
    private var buttons: some View {
        VStack(spacing: 4) {
            HistoryDetailTextView(model: viewModel.history)

            switch viewModel.history.titleType {
            case .link:
                HistoryDetailButton(title: "Open in browser", imageName: "browser", action: {})
            case .text:
                EmptyView()
            case .mail:
                HistoryDetailButton(title: "Send an email", imageName: "email", action: {})
                HistoryDetailButton(title: "Add to Contacts", imageName: "contact", action: {})
            case .phone:
                HistoryDetailButton(title: "Add to Contacts", imageName: "contact", action: {})
                HistoryDetailButton(title: "Send SMS", imageName: "sms", action: {})

            }
        }
    }
    
    private var qrImgae: some View {
        Image("qrSample")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height / 2.59)
            .cornerRadius(8)
    }
}

#Preview {
    HistoryDetailView(viewModel: HistoryDetailViewModel(history: .init(
        title: "+12025550123",
        type: .qr,
        date: Date(),
        image: "qrCode",
        titleType: .phone
    )))
}
