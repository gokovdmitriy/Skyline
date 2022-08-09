
import Foundation
extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        
        case fiolabel
        case loginLabel
        case cityLabel
        case phoneLabel
        case uidLabel
        case emailLabel
        case addressLabel
        case agreementLabel
        case statusLabel
        case depositLabel
        case daysToExpireWarning
        case daysToExpireDaysToFee
    }
    
    func resetSavedData() {
        let defaults = UserDefaults.standard
        Keys.allCases.forEach { Keys in
            defaults.removeObject(forKey: Keys.rawValue)
        }
    }
}
