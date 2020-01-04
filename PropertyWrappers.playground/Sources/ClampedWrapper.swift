import Foundation

@propertyWrapper
public struct Clamped {
    private var internalValue: Double
    // for a first version, these are lazy constants
    private let minimumValue: Double
    private let maximumValue: Double
    
    public var projectedValue: Bool
    public var wrappedValue: Double {
        get { return internalValue }
        set {
            if (newValue > maximumValue) {
                internalValue = maximumValue
                projectedValue = true
            } else if (newValue < minimumValue) {
                internalValue = minimumValue
                projectedValue = true
            } else {
                internalValue = newValue
                projectedValue = false
            }
        }
    }
    
    public init(_ value: Double, between minimum: Double, and maximum: Double) {
        // about this, the user is always right
        internalValue = value
        
        // in case the user has given us an invalid or transposed minimum & maximum
        minimumValue = min(min(value, minimum), maximum)
        maximumValue = max(max(value, maximum), minimum)
        
        // projectedValue needs an initial value before evaluating the line that follows it
        projectedValue = false
        projectedValue = (value < minimumValue) || (value > maximumValue)
    }
}
