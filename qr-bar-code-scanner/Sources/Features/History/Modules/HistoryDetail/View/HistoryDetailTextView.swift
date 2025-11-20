import SwiftUI

struct HistoryDetailTextView: View {
    let model: HistoryModel
    
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.titleType.title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color(hex: "0D0D0D").opacity(0.4))

            Text(model.title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(hex: "0D0D0D").opacity(0.9))
                .lineLimit(0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(hex: "#E6E6E6"))
        .cornerRadius(8)    }
}

#Preview {
    HistoryDetailTextView(model: .init(
        title: "+12025550123",
        type: .qr,
        date: Date(),
        image: "qrCode",
        titleType: .phone
    ))
}
