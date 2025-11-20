import Foundation

enum HistoryTitleType {
    case link
    case text
    case mail
    case phone
    
    var title: String {
        switch self {
        case .link:
            return "Link"
        case .text:
            return "Text"
        case .mail:
            return "Email"
        case .phone:
            return "Phone number"
        }
    }
}

struct HistoryModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let type: ScannerType
    let date: Date
    let image: String
    let titleType: HistoryTitleType
    
    enum ScannerType {
        case qr
        case barCode
        
        var title: String {
            switch self {
            case .qr:
                return "QR Code"
            case .barCode:
                return "Barcode"
            }
        }
    }
}
