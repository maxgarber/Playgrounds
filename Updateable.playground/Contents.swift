import Foundation

let x = 5

public class Updateable<ValueType> {

   private var _value: ValueType
   private var _updateResponses: [UUID : ((ValueType,ValueType)->Void)] = [:]

   public init(_ value: ValueType) {
       self._value = value
   }

   public func update(to value: ValueType) {
       for key in self._updateResponses.keys {
           if let response = _updateResponses[key] {
               response(self._value,value)
           }
       }
       self._value = value
   }

   public func registerResponse(_ response : @escaping ((ValueType,ValueType)->Void)) -> UUID {
       let uuid = UUID()
       self._updateResponses[uuid] = response
       return uuid
   }

   public func unregisterResponse(_ uuid: UUID) {
       self._updateResponses.removeValue(forKey: uuid)
   }

   public var value: ValueType {
       get {
           return self._value
       }
       set {
           self.update(to: newValue)
       }
   }

}


let u = Updateable(0)

let reg = u.registerResponse({ old, new in
   print("value went from \(old) to \(new)")
})

u.update(to: 2)

var done = false
while (!done) {
    sleep(5)
    let v = u.value + 5
    u.update(to: v)
    done = (v >= 35)
}
