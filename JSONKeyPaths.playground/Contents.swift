import Foundation

let data = """
***REMOVED***
    "Name": "SomeName",
    "basicAttack": ***REMOVED***
      "itemDescription": ***REMOVED***
        "description": "",
        "secondaryDescription": "1",
        "cost": "",
        "menuItems": [
          ***REMOVED***
            "description": "Damage:",
            "value": "34 + 1.5/Lvl (+20% of Magical Power)"
          ***REMOVED***,
          ***REMOVED***
            "description": "Progression:",
            "value": "None"
          ***REMOVED***
        ],
        "rankitems": [],
        "cooldown": ""
      ***REMOVED***
    ***REMOVED***,
    "ret_msg": null
***REMOVED***
""".data(using: .utf8)!

let jsonObject = JSON_Object(with:data)
let keyPath = "basicAttack.itemDescription.menuItems[1].description"
let valueAtKeyPath = jsonObject[keyPath] ?? "nil"

print("jsonObject[\(keyPath)] = \(valueAtKeyPath)")


//guard let jobj = try? JSONSerialization.jsonObject(with: data, options: []) else ***REMOVED*** exit(0) ***REMOVED***
//let nodeValue = JSON_Object_ValueFor(keyPath: keyPath, in: jobj)
//print("(JSON Object).\(keyPath) => \"\(nodeValue ?? "nil")\"")

