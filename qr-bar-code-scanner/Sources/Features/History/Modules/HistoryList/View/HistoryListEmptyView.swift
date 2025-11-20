import SwiftUI

struct HistoryListEmptyView: View {
    var body: some View {
        content
    }
    
    private var content: some View {
        HStack {
            Spacer()
            Text("Start scanning to see your result here")
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.9))
            Spacer()
        }
        .padding(.vertical, 24)
        .background(Color(hex: "#E6E6E6"))
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    HistoryListEmptyView()
}
