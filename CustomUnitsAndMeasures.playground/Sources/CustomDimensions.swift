import Foundation

class VolumeFlowRate: Dimension {
    static let cfs = VolumeFlowRate(symbol: "cfs", converter: UnitConverterLinear(coefficient: 1.0))
    static let kcfs = VolumeFlowRate(symbol: "kcfs", converter: UnitConverterLinear(coefficient: 1e3))
    static let baseUnit = cfs
}

