import Foundation

let data = """
{
    "Name": "SomeName",
    "basicAttack": {
      "itemDescription": {
        "description": "",
        "secondaryDescription": "1",
        "cost": "",
        "menuItems": [
          {
            "description": "Damage:",
            "value": "34 + 1.5/Lvl (+20% of Magical Power)"
          },
          {
            "description": "Progression:",
            "value": "None"
          }
        ],
        "rankitems": [],
        "cooldown": ""
      }
    },
    "ret_msg": null
}
""".data(using: .utf8)!

let jsonObject = JSON_Object(with:data)
let keyPath = "basicAttack.itemDescription.menuItems[1].description"
let valueAtKeyPath = jsonObject[keyPath] ?? "nil"

print("jsonObject[\(keyPath)] = \(valueAtKeyPath)")


//guard let jobj = try? JSONSerialization.jsonObject(with: data, options: []) else { exit(0) }
//let nodeValue = JSON_Object_ValueFor(keyPath: keyPath, in: jobj)
//print("(JSON Object).\(keyPath) => \"\(nodeValue ?? "nil")\"")

