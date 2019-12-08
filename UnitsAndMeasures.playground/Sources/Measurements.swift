import Foundation

public typealias Unit = String

public typealias UnitExpr = [(units: Unit, exponent: Int)]

public class ScalarMeasurement {
    public var value: Double = 0.0
    public var units: [(units: Unit, exponent: Int)] = []
    
    public init(value v: Double, units u: Unit) {
        self.value = v
        self.units = [(units: u, exponent: 1)]
    }
}
typealias Measurement = ScalarMeasurement
