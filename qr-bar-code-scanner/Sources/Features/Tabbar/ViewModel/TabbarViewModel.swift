import SwiftUI

enum TabbarType: Int, CaseIterable {
    case history = 0
    case scanner
    case setting
    
    var imageName: String {
        switch self {
        case .history:
            return "history"
        case .scanner:
            return "scanner"
        case .setting:
            return "settings"
        }
    }
}

final class TabbarViewModel: ObservableObject {
    
    @Published var selectedType: TabbarType = .scanner
}
