import Foundation

public final class MGAscendingTreeNode<Value: CustomStringConvertible>: CustomStringConvertible, AscendingTreeNode {
    
    public var value: Value
    
    public var parent: MGAscendingTreeNode<Value>?
    
    public var description: String {
        return "<MGAscendingTreeNode value=\"\(value.description)\">"
    }
    
    public init(_ value: Value, parent: MGAscendingTreeNode<Value>? = nil) {
        self.value = value
        self.parent = parent
    }
    
}
