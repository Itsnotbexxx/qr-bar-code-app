import SwiftUI

struct HistoryDetailButton: View {
    let title: String
    let imageName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .background(Color.white)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(hex: "#0D0D0D", opacity: 0.9))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(Color.white)
            .cornerRadius(8)
        }
    }
}

#Preview {
    HistoryDetailButton(title: "Open in browser", imageName: "browser", action: {})
}
