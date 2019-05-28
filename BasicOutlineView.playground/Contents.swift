import AppKit
import Cocoa
import Foundation
import PlaygroundSupport


let nib = "MyView"
var ovc = MGOutlineViewController()

var chaos = MGOutlineViewItem("Chaos")
chaos.image = NSImage.init(named: NSImage.advancedName)
chaos.children.append(MGOutlineViewItem("Tartarus"))
chaos.children.append(MGOutlineViewItem("Eros"))
chaos.children.append(MGOutlineViewItem("Erebus"))

var gaea = MGOutlineViewItem("Gaea")
gaea.image = NSImage.init(named: NSImage.networkName)
chaos.children.append(gaea)

var uranus = MGOutlineViewItem("Uranus")
uranus.children.append(MGOutlineViewItem("Cyclope"))
uranus.children.append(MGOutlineViewItem("Hecatonchires"))
uranus.children.append(MGOutlineViewItem("Cronus+Rhea"))
uranus.children.append(MGOutlineViewItem("Coeus+Phoebe"))
uranus.children.append(MGOutlineViewItem("Oceanus+Tethys"))
gaea.children.append(uranus)
gaea.children.append(MGOutlineViewItem("Mountains"))
gaea.children.append(MGOutlineViewItem("Pontus"))


ovc.items.append(chaos)
loadViewFromNib(nib, withOwner: ovc)
ovc.preferredContentSize = NSMakeSize(256, 768)
presentViewForController(ovc)
