import SwiftUI

struct PayrollView<ViewModel: PayrollViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ZStack(alignment: .topTrailing) {
                content
                
                Button(action: {
                    viewModel.resultSubject.send(.onTapContinue)
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                .padding(.top, 20)
                .padding(.trailing, 16)
            }
    }
    
    private var content: some View {
        VStack {
            Spacer()
            bottomView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("payroll")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .transition(.opacity)
        )
    }
    
    private var bottomView: some View {
        VStack(spacing: 16) {
            titelView
            ActionButton(title: "Continue") {
                viewModel.resultSubject.send(.onTapContinue)
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
            Text("Unlock unlimited scans")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.9))

            Text("Get full access with unlimited barcode and QR scans — no limits, no interruptions")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.6))
            Text("Subscribe to unlock all the features for just $4.99/week")
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.4))
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

#Preview {
    PayrollView(viewModel: PayrollViewModel())
}
