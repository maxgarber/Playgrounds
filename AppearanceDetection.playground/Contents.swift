import Foundation

#if canImport(AppKit)
import AppKit

print("Appearance is: \(NSApplication.shared.effectiveAppearance.isDark ? "dark" : "light")")

#elseif canImport(UIKit)
import UIKit

print("Appearance is: \(UITraitCollection.appearanceIsDark ? "dark" : "light")")

#endif

