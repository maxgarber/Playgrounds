import Foundation

struct testStruct_Unitary {
    @Unitary(0.0) var x: Double
}

public func testUnitary () -> Bool {
    
    var ts = testStruct_Unitary()
    
    print("ts initialized to 0.0")
    print("  ts.x  => \(ts.x)")
    print("  ts.$x => \(ts.$x)")
    ts.x = -1.0
    print("ts assigned to -1.0")
    print("  ts.x  => \(ts.x)")
    print("  ts.$x => \(ts.$x)")
    ts.x = 0.50
    print("ts.x assigned to 0.50")
    print("  ts.x  => \(ts.x)")
    print("  ts.$x => \(ts.$x)")
    ts.x = 1.25
    print("ts.x assigned to 1.25")
    print("  ts.x  => \(ts.x)")
    print("  ts.$x => \(ts.$x)")
    
    return true
}
