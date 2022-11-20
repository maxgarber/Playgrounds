import Foundation

#if canImport(UIKit)
import UIKit

public extension UITraitCollection {
    
    static var appearanceIsDark: Bool {
        return UITraitCollection.current.userInterfaceStyle == .dark
    }
    
}

#endif // canImport(UIKit)
