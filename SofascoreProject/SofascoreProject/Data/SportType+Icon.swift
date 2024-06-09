import Foundation
import UIKit

extension SportType {

    var icon: UIImage {
        switch self {
        case .football:
            return .football
        case .basketball:
            return .basketball
        case .americanFootball:
            return .americanFootball
        }
    }
    
    var url: String {
        switch self {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .americanFootball:
            return "american-football"
        }
    }
}
