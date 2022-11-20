import Foundation

#if canImport(AppKit)
import AppKit

@available(macOS 10.9, *)
public extension NSAppearance {
    
    var isDark: Bool {
        switch self.name {
        case .darkAqua,
             .vibrantDark,
             .accessibilityHighContrastDarkAqua,
             .accessibilityHighContrastVibrantDark:
            return true
        default:
            return false
        }
    }
    
    var isVibrant: Bool {
        switch self.name {
        case  .vibrantLight,
              .vibrantDark,
              .accessibilityHighContrastVibrantLight,
              .accessibilityHighContrastVibrantDark:
            return true
        default:
            return false
        }
    }
    
    var isHighContrast: Bool {
        switch self.name {
        case .accessibilityHighContrastAqua,
              .accessibilityHighContrastDarkAqua,
              .accessibilityHighContrastVibrantLight,
              .accessibilityHighContrastVibrantDark:
            return true
        default:
            return false
        }
    }
    
}

#endif // canImport(AppKit)
