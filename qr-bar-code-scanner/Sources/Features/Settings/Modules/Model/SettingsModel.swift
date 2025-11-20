import Foundation

enum SettingsActionType {
    case button
    case toggle
    case buttonArrow
}

enum SettingsType: Int, CaseIterable {
    case policy = 0
    case terms
    case share
    case support
    case autoOpen
    case vibraiton
    case limit
    
    var title: String {
        switch self {
        case .policy:
            return "Privacy Policy"
        case .terms:
            return "Terms of Use"
        case .share:
            return "Share App"
        case .support:
            return "Support"
        case .autoOpen:
            return "Auto-open links after scan"
        case .vibraiton:
            return "Vibration on successful scan"
        case .limit:
            return "History limit: 50"
        }
    }
    
    var imageName: String {
        switch self {
        case .policy:
            return "pp"
        case .terms:
            return "terms"
        case .share:
            return "share"
        case .support:
            return "support"
        default:
            return ""
        }
    }
    
    var actionType: SettingsActionType {
        switch self {
        case .policy, .terms, .share, .support:
            return .button
        case .autoOpen, .vibraiton:
            return .toggle
        case .limit:
            return .buttonArrow
        }
    }
}
