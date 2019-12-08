import Foundation


public class Updateable<ValueType> {

    public typealias UpdateResponse = ((ValueType,ValueType)->Void)
    
    private var _value: ValueType
    private var _updateResponses: [UUID : UpdateResponse] = [:]
    
    public init(_ value: ValueType) {
        _value = value
    }
    
    public func update(to value: ValueType) {
        for uuid in _updateResponses.keys {
            if let response = _updateResponses[uuid] {
                response(_value,value)
            }
        }
        _value = value
    }
    
    public func registerResponse(_ response : @escaping UpdateResponse) -> UUID {
        let uuid = UUID()
        _updateResponses[uuid] = response
        return uuid
    }
    
    public func unregisterResponse(_ uuid: UUID) {
        _updateResponses.removeValue(forKey: uuid)
    }
    
    public var value: ValueType {
        get {
            return _value
        }
        set {
            update(to: newValue)
        }
    }
    
}
