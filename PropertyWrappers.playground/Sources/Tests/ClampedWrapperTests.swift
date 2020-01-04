import Foundation

struct testStruct_Clamped {
    @Clamped(5.0, between: 0.0, and: 10.0) var x: Double
}

public func testClamped () -> Bool {
    
    var tsc = testStruct_Clamped()
    
    print("tsc initialized with 5.0, between 0.0 and 10.0")
    print("  tsc.x  => \(tsc.x)")
    print("  tsc.$x => \(tsc.$x)")
    tsc.x = -1.0
    print("tsc assigned to -1.0")
    print("  tsc.x  => \(tsc.x)")
    print("  tsc.$x => \(tsc.$x)")
    tsc.x = 1.25
    print("ts.x assigned to 1.25")
    print("  tsc.x  => \(tsc.x)")
    print("  tsc.$x => \(tsc.$x)")
    tsc.x = 12.5
    print("ts.x assigned to 12.5")
    print("  tsc.x  => \(tsc.x)")
    print("  tsc.$x => \(tsc.$x)")
    
    return true
}
