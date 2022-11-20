// Enum Equatability with Subteties
import Foundation

enum SolarSatellite: Equatable {
    case mercury
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    
    case dwarfPlanet(String)
    case anyDwarfPlanet
    
    static func == (lhs: SolarSatellite, rhs: SolarSatellite) -> Bool {
        switch (lhs, rhs) {
        // if either or both of the operands is/are anyDwarfPlanet, they're equal
        case (.anyDwarfPlanet, .anyDwarfPlanet),
             (.anyDwarfPlanet, .dwarfPlanet(let _)),
             (.dwarfPlanet(let _), .anyDwarfPlanet):
            return true
        // if both are a named dwarf planet, they are equal only if their names are
        case (.dwarfPlanet(let leftName), .dwarfPlanet(let rightName)):
            return leftName == rightName
        // otherwise, they both have to be the same specific enum-case
        case (.mercury, .mercury),
             (.venus, .venus),
             (.earth, .earth),
             (.mars, .mars),
             (.jupiter, .jupiter),
             (.saturn, .saturn),
             (.uranus, .uranus),
             (.neptune, .neptune):
             return true
        // ...or else they are not equal
        default:
            return false
        }
    }
}

let home: SolarSatellite = .earth
let pluto: SolarSatellite = .dwarfPlanet("Pluto")
let ceres: SolarSatellite = .dwarfPlanet("Ceres")
let anyDwarfPlanet: SolarSatellite = .anyDwarfPlanet

home == .earth
pluto == pluto
ceres == pluto
anyDwarfPlanet == anyDwarfPlanet
pluto == .anyDwarfPlanet
ceres == .anyDwarfPlanet

