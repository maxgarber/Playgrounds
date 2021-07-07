import Foundation


/// A bottom-up tree node that is ignorant of its children, but tracks its parent
public protocol AscendingTreeNode {
    
    associatedtype Value
    
    var value: Value { get }
    
    var parent: Self? { get }
    
}

public extension AscendingTreeNode where Value: CustomStringConvertible {
    
    /// Produces a text-based outline of the tree using the receiving node as the roo
    func textualRepresentation() -> String {
        var ancestry: [Self] = []
        var node: Self? = self
        
        while node != nil {
            ancestry.append(node!)
            node = node!.parent
        }
        
        let text = ancestry.map({ $0.value.description }).joined(separator: " ⟵ ")
        return text
    }
    
}

