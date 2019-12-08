import Foundation


public enum JSON_Key: CustomStringConvertible, Hashable {
    case string(String)
    case index(Int)
    
    public var description: String {
        switch (self) {
        case let .string(string):
            return string
        case let .index(index):
            return String(index)
        }
    }
}

public enum JSON_Value: Hashable {
    case string(String)
    case integer(Int)
    case float(Float)
    case bool(Bool)
    case array([JSON_Value])
    case object([String:JSON_Value])
    case null
}


// @todo instead of producing just nil, should create/throw an error describing where it went awry
public struct JSON_Object {
    private let data: Data
    
    public init(with data: Data) {
        self.data = data
    }
    
    private func recFind(keypathStack: inout [JSON_Key], subtreeNode someObject: Any) -> Any? {
        var valueToReturn: Any? = nil
        let keyPathElement = keypathStack.popLast()
        switch (keyPathElement) {
        case let .string(key):
            valueToReturn = (someObject as? [String : Any])?[key] ?? nil
        case let .index(index):
            valueToReturn = (someObject as? [Any])?[index] ?? nil
        default:
            valueToReturn = nil
        }
        if !keypathStack.isEmpty, valueToReturn != nil {
            valueToReturn = recFind(keypathStack: &keypathStack, subtreeNode: valueToReturn!)
        }
        return valueToReturn
    }
    
    public func valueFor(keypath: String) -> Any? {
        var keypath_stack: [JSON_Key] = keypath
            .components(separatedBy: CharacterSet(charactersIn: ".[]"))
            .filter({ (s: String) in s != "" })
            .reversed()
            .map({ x in
                if let idx = Int(x) {
                    return JSON_Key.index(idx)
                } else {
                    return JSON_Key.string(x)
                }
            })
        if let someObject = try? JSONSerialization.jsonObject(with: data, options:[]) {
            return recFind(keypathStack: &keypath_stack, subtreeNode: someObject)
        } else {
            return nil
        }
    }
    
    public subscript(_ keypath: String) -> Any? {
        return valueFor(keypath: keypath)
    }
}
