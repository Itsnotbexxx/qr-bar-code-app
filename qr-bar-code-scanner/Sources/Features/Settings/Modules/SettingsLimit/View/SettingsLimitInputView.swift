import SwiftUI

struct SettingsLimitInputView: View {
    @State private var maxItems: String = "50"
    
    var body: some View {
        content
    }
    
    private var content: some View {
        HStack {
            Text("Maximum items to keep")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.init(hex: "##0D0D0D", opacity: 0.9))
            
            Spacer()
            
            TextField("", text: $maxItems)
                   .keyboardType(.numberPad)
                   .multilineTextAlignment(.center)
                   .frame(width: 48, height: 48)
                   .background(Color.white)
                   .cornerRadius(8)
        }
        .padding(.horizontal, 18)
        .frame(height: 56)
        .background(Color(hex: "#E6E6E6"))
        .cornerRadius(8)
    }
}

#Preview {
    SettingsLimitInputView()
}
