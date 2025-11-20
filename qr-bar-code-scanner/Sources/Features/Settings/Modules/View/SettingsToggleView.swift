import SwiftUI

struct SettingsToggleView: View {
    let title: String
    @State var isOn: Bool
    
    var body: some View {
        content
    }
    
    private var content: some View {
        HStack {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.init(hex: "##0D0D0D", opacity: 0.9))

            Spacer()

            Toggle("asdasddasdads", isOn: $isOn)
                .labelsHidden()
                .tint(.init(hex: "##0D0D0D", opacity: 0.9))
        }
        .padding(.horizontal, 18)
        .frame(height: 56)
        .background(Color(hex: "#E6E6E6"))
        .cornerRadius(4)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SettingsToggleView(title: "Auto-open links after scan", isOn: true)
}
