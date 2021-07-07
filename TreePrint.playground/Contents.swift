import Foundation


// Custom-built class

let root = MGTreeNode(name: "Root", children: [
    MGTreeNode(name: "A", children: [
        MGTreeNode(name: "α"),
        MGTreeNode(name: "β", children: [
            MGTreeNode(name: "1"),
            MGTreeNode(name: "2"),
            MGTreeNode(name: "3"),
            MGTreeNode(name: "4")
        ]),
        MGTreeNode(name: "γ")
    ]),
    MGTreeNode(name:"B"),
    MGTreeNode(name:"C"),
    MGTreeNode(name:"D")
])

print(root.textualRepresentation())

// Minimalist Protocol Implementers

let root2 = MGDescendingTreeNode("Root")
let child1 = MGDescendingTreeNode("A")
root2.children.append(child1)
let child2 = MGDescendingTreeNode("B")
root2.children.append(child2)
let child3 = MGDescendingTreeNode("1")
child2.children.append(child3)
let child4 = MGDescendingTreeNode("2")
child2.children.append(child4)
let child5 = MGDescendingTreeNode("C")
root2.children.append(child5)

print(root2.textualRepresentation())


let a = MGAscendingTreeNode("A")
let b = MGAscendingTreeNode("B")
b.parent = a
let c = MGAscendingTreeNode("C")
c.parent = b
let d = MGAscendingTreeNode("D")
d.parent = c

print(d.textualRepresentation())
