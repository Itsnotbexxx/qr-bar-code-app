import SwiftUI
import AVKit

final class CameraScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedModel: HistoryModel?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaObject = metadataObjects.first {
            guard let readebleObject = metaObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let code = readebleObject.stringValue else { return }
            print(code)
            let titleType = detectHistoryType(for: code)
            scannedModel = .init(
                title: code,
                type: .qr,
                date: Date(),
                image: "",
                titleType: titleType
            )
        }
    }
    
    private func detectHistoryType(for string: String) -> HistoryTitleType {
        if string.starts(with: "http://") || string.starts(with: "https://") {
            return .link
        }
        
        if let _ = URL(string: string), string.contains(".") {
            return .link
        }
        
        if isValidEmail(string) {
            return .mail
        }
        
        if isValidPhone(string) {
            return .phone
        }
        
        return .text
    }
    
    private func isValidEmail(_ string: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: string)
    }

    private func isValidPhone(_ string: String) -> Bool {
        let phoneRegEx = "^[0-9+\\-() ]{6,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return predicate.evaluate(with: string)
    }
}
