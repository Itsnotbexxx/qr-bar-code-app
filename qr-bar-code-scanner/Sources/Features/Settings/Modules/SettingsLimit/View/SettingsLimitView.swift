import SwiftUI

struct SettingsLimitView<ViewModel: SettingsLimitViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        content
    }
    
    private var content: some View {
        VStack(spacing: 4) {
            SettingsToggleView(title: "Limit saved scans in history", isOn: false)
            
            SettingsLimitInputView()
            SettingsLimitWarningView()
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color(hex: "#DADADA"))
    }
}

#Preview {
    SettingsLimitView(viewModel: SettingsLimitViewModel())
}


struct SettingsLimitWarningView: View {
    var body: some View {
        content
    }
    
    private var content: some View {
        HStack {
            Spacer()
            Text("When the history limit is reached, the oldest item will be removed automatically")
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.9))
            Spacer()
        }
        .padding(.vertical, 24)
        .background(Color(hex: "#E6E6E6"))
        .cornerRadius(8)
    }
}
