import Foundation

public final class MGDescendingTreeNode<Value: CustomStringConvertible>: CustomStringConvertible, DescendingTreeNode {
    
    public var value: Value
    
    public var children = [MGDescendingTreeNode<Value>]()
    
    public var description: String {
        return "<MGDescendingTreeNode value=\"\(value.description)\">"
    }
    
    public init(_ value: Value) {
        self.value = value
    }
}
