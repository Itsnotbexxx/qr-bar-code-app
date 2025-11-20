import SwiftUI

struct OnboardingView<ViewModel: OnboardingViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        content
    }
    
    private var content: some View {
        VStack {
            Spacer()
            bottomView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(viewModel.mode.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.5), value: viewModel.mode)
        )
        .animation(.easeInOut(duration: 0.5), value: viewModel.mode)

    }
    
    private var bottomView: some View {
        VStack(spacing: 16) {
            titelView
            ActionButton(title: "Continue") {
                viewModel.onTapNext()
            }
            linkView
        }
        .padding(16)
        .background(Color(hex: "#E6E6E6"))
        .cornerRadius(8)
        .padding()
    }
    
    private var titelView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(viewModel.mode.title)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.9))


            Text(viewModel.mode.subtitle)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.6))
        }
    }
    
    private var linkView: some View {
        HStack(spacing: 16) {
            LinkButton(title: "Terms of Use") {
                print("Terms of Use")
            }
            
            Spacer()
            
            LinkButton(title: "Restore") {
                print("Restore")
            }
            
            Spacer()
            
            LinkButton(title: "Privacy Policy") {
                print("Privacy Policy")
            }
        }
    }
}

//#Preview {
//    OnboardingView(viewModel: OnboardingViewModel())
//}
