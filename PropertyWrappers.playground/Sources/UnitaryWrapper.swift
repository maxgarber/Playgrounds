import Foundation

@propertyWrapper
public struct Unitary {
    private var internalValue: Double = 1.0

    public var projectedValue = false
    public var wrappedValue: Double {
        get { return internalValue }
        set {
            if (newValue > 1.0) {
                internalValue = 1.0
                projectedValue = true
            } else if (newValue < 0.0) {
                internalValue = 0.0
                projectedValue = true
            } else {
                internalValue = newValue
                projectedValue = false
            }
        }
    }
    
    public init(_ value: Double) {
        wrappedValue = value
        // does the setter block declared above get used for initialization?
    }
}
