import SwiftUI

struct ActionButton: View {
    let title: String
    var backgroundColor: Color = .init(hex: "#1A1A1A")
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .cornerRadius(8)
        }
    }
}

#Preview {
    ActionButton(title: "Continue", action: {})
}
