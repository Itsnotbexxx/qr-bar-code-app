import SwiftUI

struct SettingsButtonArrow: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.init(hex: "##0D0D0D", opacity: 0.9))
                Spacer()
                
                Image("forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 18)
            .frame(height: 56)
            .background(Color(hex: "#E6E6E6"))
            .cornerRadius(4)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    SettingsButtonArrow(title: "History limit: 50", action: {})
}
