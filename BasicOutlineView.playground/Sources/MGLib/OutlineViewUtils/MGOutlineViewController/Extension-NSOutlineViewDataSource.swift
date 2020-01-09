import Foundation
import AppKit


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

