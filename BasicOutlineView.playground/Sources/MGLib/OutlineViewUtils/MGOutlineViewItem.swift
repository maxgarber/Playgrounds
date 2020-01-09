import AppKit
import Cocoa
import Foundation


public class MGOutlineViewItem: NSObject, OutlineViewItem {
	
	public var name: String = ""
	public var children: [OutlineViewItem] = []
	public var image: NSImage? = nil
	public var isGroup: Bool = false
	
	public convenience init(_ name: String) {
		self.init()
		self.name = name
	}
	
	public convenience init(_ name: String, image: NSImage) {
		self.init()
		self.name = name
		self.image = image
	}
	
	public static func makeGroup(_ groupName: String) -> MGOutlineViewItem {
		let item = MGOutlineViewItem(groupName)
		item.isGroup = true
		return item
	}
	
}
