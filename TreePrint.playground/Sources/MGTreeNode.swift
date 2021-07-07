import Foundation


public class MGTreeNode: Equatable, CustomDebugStringConvertible {
    
    private let id = UUID()
    
    public var name: String
    
    public private(set) var parent: MGTreeNode? = nil
    
    public private(set) var children: [MGTreeNode] = []
    
    public init(name: String, parent: MGTreeNode? = nil, children: [MGTreeNode] = []) {
        self.name = name
        self.parent = parent
        self.children = children
        
        defer {
            self.parent?.children.append(self)
            children.forEach({ $0.parent = self })
        }
    }
    
    public func move(toParent newParent: MGTreeNode) {
        self.parent = newParent
        newParent.children.append(self)
    }
    
    public func addChild(_ newChild: MGTreeNode) {
        self.children.append(newChild)
        newChild.parent = self
    }
    
    @discardableResult public func removeChild(at index: Int) -> MGTreeNode? {
        guard index >= children.count else { return nil }
        let child = children.remove(at: index)
        child.parent = nil
        return child
    }
    
    public var isLastOrOnlyChild: Bool {
        if let parent = self.parent, let lastChildOfParent = parent.children.last {
            return self == lastChildOfParent
        } else {
            return true
        }
    }
    
    public static func == (lhs: MGTreeNode, rhs: MGTreeNode) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func textualRepresentation(withLinePrefix prefix: String = "") -> String {
        
        var text = ""
        // if the parent is nil, we're at root and need to print ourself
        if parent == nil {
            text += prefix + name + "\n"
        }
        for child in self.children {
            var textToAdd = prefix + (child.isLastOrOnlyChild ? "└╴" : "├╴") + child.name + "\n"
            if child.children.count > 0 {
                textToAdd += child.textualRepresentation(withLinePrefix: prefix + "│ ")
            }
            text += textToAdd
        }
        
        return text
    }
    
    public var debugDescription: String {
        var debugDescription = "<MGRootNode name=\"\(name)\" parent=\( parent?.name ?? "nil" ) isLastOrOnlyChild=\( isLastOrOnlyChild ? "yes" : "no" ) id=\(id) children={"
        debugDescription += self.children.map({ $0.name }).joined(separator: ", ")
        debugDescription += "}>"
        return debugDescription
    }
}


