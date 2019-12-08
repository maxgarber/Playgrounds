import Foundation

public enum FundamentalAttribute {
    case mass
    case length
    case time
    case current
    case temperature
    case amount
    case luminosity
}

//public protocol Unit {
//    var symbol: String { get }
//    var name: String { get }
//    var attribute: FundamentalAttribute { get }
//}
//
//public typealias UnitsExpression = [(unit: Unit, degree: Int)]
//
//public struct Metre: Unit {
//    public var symbol: String = "m"
//    public var name: String = "meter"
//    public var attribute: FundamentalAttribute = .length
//    
//    public static * (lhs: Metre, rhs: Metre) -> UnitsExpression {
//        return [(unit: lhs, degree: 2)]
//    }
//    
//}




/* Unicode units symbols (from CJK Compatibility, U+3371 ... U+33DD)
 
 ㍱㍲㍳㍴㍵㍶
 ㎀㎁㎂㎃㎄
 ㎅㎆㎇
 ㎈㎉
 ㎊㎋㎌
 ㎍㎎㎏
 ㎐㎑㎒㎓㎔
 ㎕㎖㎗㎘
 ㎙㎚㎛㎜㎝㎞
 ㎟㎠㎡㎢㎣㎤㎥㎦
 ㎧㎨
 ㎩㎪㎫㎬
 ㎭㎮㎯
 ㎰㎱㎲㎳
 ㎴㎵㎶㎷㎸㎹
 ㎺㎻㎼㎽㎾㎿
 ㏀㏁
 ㏂㏘
 ㏃㏄㏅㏆㏇㏈㏉㏊㏋㏌㏍㏎㏏㏐㏑㏒㏓㏔㏕㏖㏗㏙㏚㏛㏜㏝
 
 */
