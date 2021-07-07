import Foundation


/// A typical top-down tree node that is ignorant of its parent, but tracks its children
public protocol DescendingTreeNode {
    
    associatedtype Value
    
    var value: Value { get }
    
    var children: [Self] { get }
    
}

public extension DescendingTreeNode where Value: CustomStringConvertible {
    
    /// Produces a text-based outline of the tree using the receiving node as the roo
    func textualRepresentation() -> String {
        var text = self.value.description + "\n"
        text += _textualRepresentation(node: self, prefix: "")
        return text
    }
    
}

// Recursive descent function
private func _textualRepresentation<Node>(node: Node, prefix: String) -> String where Node: DescendingTreeNode, Node.Value: CustomStringConvertible {
    var text = ""
    
    for (index, child) in node.children.enumerated() {
        var textToAdd = prefix
        if (node.children.count == 1 || index == node.children.count - 1) {
            // only or last child
            textToAdd += "└╴"
        } else {
            textToAdd += "├╴"
        }
        textToAdd += child.value.description + "\n"
        if child.children.count > 0 {
            textToAdd += _textualRepresentation(node: child, prefix: prefix + "│ ")
        }
        text += textToAdd
    }
    
    return text
}


