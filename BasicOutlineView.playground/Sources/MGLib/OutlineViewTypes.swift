import AppKit
import Cocoa
import Foundation


public class MGOutlineViewItem: NSObject, OutlineViewItem {
	
	public var name: String = ""
	public var children: [OutlineViewItem] = []
	public var image: NSImage? = nil
	
	public convenience init(_ name: String) {
		self.init()
		self.name = name
	}
	
}


public class MGOutlineViewController: NSViewController, OutlineViewController {
	public var items: [OutlineViewItem] = []
}

extension MGOutlineViewController: NSOutlineViewDataSource {
	
	public func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
		if let item = item as? MGOutlineViewItem {
			return (item.children.count > 0)
		} else {
			return (items.count > 0)
		}
	}
	
	public func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
		if let item = item as? MGOutlineViewItem {
			return item.children.count
		} else {
			return items.count
		}
	}
	
	public func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
		if let item = item as? MGOutlineViewItem {
			return item.children[index]
		} else {
			return items[index]
		}
	}
	
}


extension MGOutlineViewController: NSOutlineViewDelegate {
	
	public func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
		if let item = item as? MGOutlineViewItem {
			let cellView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TableEntryCell"), owner: self) as? NSTableCellView
			cellView?.textField?.stringValue = item.name
			cellView?.imageView?.image = item.image
			return cellView
		}
		return nil
	}
	
	
}
