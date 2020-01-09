import AppKit
import Cocoa
import Foundation
import PlaygroundSupport


let nib = "MyView"
var ovc = MGOutlineViewController()

var planets = MGOutlineViewItem.makeGroup("Planets")

guard let folderIcon = NSImage(named: NSImage.folderName) else { fatalError() }
guard let userIcon = NSImage(named: NSImage.userName) else { fatalError() }
guard let otherIcon = NSImage(named: NSImage.statusAvailableName) else { fatalError() }

var innerPlanets = MGOutlineViewItem("Inner Planets", image: folderIcon)
innerPlanets.children.append(MGOutlineViewItem("Mercury", image: userIcon))
innerPlanets.children.append(MGOutlineViewItem("Venus", image: userIcon))
innerPlanets.children.append(MGOutlineViewItem("Earth", image: userIcon))
innerPlanets.children.append(MGOutlineViewItem("Mars", image: userIcon))
planets.children.append(innerPlanets)

var outerPlanets = MGOutlineViewItem("Outer Planets", image: folderIcon)
outerPlanets.children.append(MGOutlineViewItem("Jupiter", image: userIcon))
outerPlanets.children.append(MGOutlineViewItem("Saturn", image: userIcon))
outerPlanets.children.append(MGOutlineViewItem("Uranus", image: userIcon))
outerPlanets.children.append(MGOutlineViewItem("Neptune", image: userIcon))
planets.children.append(outerPlanets)

ovc.items.append(planets)

loadViewFromNib(nib, withOwner: ovc)
ovc.preferredContentSize = NSMakeSize(256, 768)
presentViewForController(ovc)
