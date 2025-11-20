import SwiftUI

struct SettingsView<ViewModel: SettingsViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        content
    }
    
    private var content: some View {
        VStack(spacing: 4) {
            ForEach(
                SettingsType.allCases.filter {
                    $0.actionType == .button
                },
                id: \.self) { type in
                    SettingsButtonView(
                        title: type.title,
                        imageName: type.imageName) {
                            print("button type")
                        }
                        .padding(.horizontal, 16)
                }
            
            ForEach(
                SettingsType.allCases.filter {
                    $0.actionType == .toggle
                },
                id: \.self) { type in
                    SettingsToggleView(title: type.title, isOn: false)
                        .padding(.horizontal, 16)
                }
            
            ForEach(
                SettingsType.allCases.filter {
                    $0.actionType == .buttonArrow
                },
                id: \.self) { type in
                    SettingsButtonArrow(title: type.title, action: {
                        viewModel.resultSubject.send(.onTapContinue)
                    })
                        .padding(.horizontal, 16)
                }
            
            Spacer()
        }
        .background(Color(hex: "#DADADA"))
    }
}

#Preview {
    SettingsView(viewModel: SettingsViewModel())
}
