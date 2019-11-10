import Foundation


//
public enum JSON_Key: CustomStringConvertible, Hashable ***REMOVED***
    case string(String)
    case index(Int)
    
    public var description: String ***REMOVED***
        switch (self) ***REMOVED***
        case let .string(string):
            return string
        case let .index(index):
            return String(index)
        ***REMOVED***
    ***REMOVED***
***REMOVED***


//
// @todo implement CustomStringConvertible
public enum JSON_Value: /* CustomStringConvertible, */ Hashable ***REMOVED***
    case string(String)
    case integer(Int)
    case float(Float)
    case bool(Bool)
    case array([JSON_Value])
    case object([String:JSON_Value])
    case null
    
//    public var description: String ***REMOVED***
//        switch (self) ***REMOVED***
//        case let .array(arr):
//            var str: String = "["
//            arr.forEach(***REMOVED*** v in str.append(v.description + ",") ***REMOVED***)
//            return str + "]"
//        case let .object(dict):
//            var str: String = "***REMOVED***"
//            dict.forEach ***REMOVED*** (key: String, value: JSON_Value) in
//                str.append( key + ": " + value.description + ", " )
//            ***REMOVED***
//            return str + "***REMOVED***"
//        case .null: return "null"
//        case let .bool(bool): return bool ? "True":"False"
//        case let .float(float): return String(float)
//        case let .integer(integer): return String(integer)
//        case let .string(string): return string
//        ***REMOVED***
//    ***REMOVED***
***REMOVED***

// @todo instead of producing just nil, should create/throw an error describing where it went awry
public struct JSON_Object ***REMOVED***
    private let data: Data
    
    public init(with data: Data) ***REMOVED***
        self.data = data
    ***REMOVED***
    
    private func recFind(keypathStack: inout [JSON_Key], subtreeNode someObject: Any) -> Any? ***REMOVED***
        var valueToReturn: Any? = nil
        let keyPathElement = keypathStack.popLast()
        switch (keyPathElement) ***REMOVED***
        case let .string(key):
            valueToReturn = (someObject as? [String : Any])?[key] ?? nil
        case let .index(index):
            valueToReturn = (someObject as? [Any])?[index] ?? nil
        default:
            valueToReturn = nil
        ***REMOVED***
        if !keypathStack.isEmpty, valueToReturn != nil ***REMOVED***
            valueToReturn = recFind(keypathStack: &keypathStack, subtreeNode: valueToReturn!)
        ***REMOVED***
        return valueToReturn
    ***REMOVED***
    
    public func valueFor(keypath: String) -> Any? ***REMOVED***
        var keypath_stack: [JSON_Key] = keypath
            .components(separatedBy: CharacterSet(charactersIn: ".[]"))
            .filter(***REMOVED*** (s: String) in s != "" ***REMOVED***)
            .reversed()
            .map(***REMOVED*** x in
                if let idx = Int(x) ***REMOVED***
                    return JSON_Key.index(idx)
                ***REMOVED*** else ***REMOVED***
                    return JSON_Key.string(x)
                ***REMOVED***
            ***REMOVED***)
        if let someObject = try? JSONSerialization.jsonObject(with: data, options:[]) ***REMOVED***
            return recFind(keypathStack: &keypath_stack, subtreeNode: someObject)
        ***REMOVED*** else ***REMOVED***
            return nil
        ***REMOVED***
    ***REMOVED***
    
    public subscript(_ keypath: String) -> Any? ***REMOVED***
        return valueFor(keypath: keypath)
    ***REMOVED***
***REMOVED***
