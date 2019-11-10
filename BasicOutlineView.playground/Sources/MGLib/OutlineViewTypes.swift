import AppKit
import Cocoa
import Foundation


public class MGOutlineViewItem: NSObject, OutlineViewItem ***REMOVED***
	
	public var name: String = ""
	public var children: [OutlineViewItem] = []
	public var image: NSImage? = nil
	
	public convenience init(_ name: String) ***REMOVED***
		self.init()
		self.name = name
	***REMOVED***
	
***REMOVED***


public class MGOutlineViewController: NSViewController, OutlineViewController ***REMOVED***
	public var items: [OutlineViewItem] = []
***REMOVED***

extension MGOutlineViewController: NSOutlineViewDataSource ***REMOVED***
	
	public func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool ***REMOVED***
		if let item = item as? MGOutlineViewItem ***REMOVED***
			return (item.children.count > 0)
		***REMOVED*** else ***REMOVED***
			return (items.count > 0)
		***REMOVED***
	***REMOVED***
	
	public func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int ***REMOVED***
		if let item = item as? MGOutlineViewItem ***REMOVED***
			return item.children.count
		***REMOVED*** else ***REMOVED***
			return items.count
		***REMOVED***
	***REMOVED***
	
	public func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any ***REMOVED***
		if let item = item as? MGOutlineViewItem ***REMOVED***
			return item.children[index]
		***REMOVED*** else ***REMOVED***
			return items[index]
		***REMOVED***
	***REMOVED***
	
***REMOVED***


extension MGOutlineViewController: NSOutlineViewDelegate ***REMOVED***
	
	public func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? ***REMOVED***
		if let item = item as? MGOutlineViewItem ***REMOVED***
			let cellView = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TableEntryCell"), owner: self) as? NSTableCellView
			cellView?.textField?.stringValue = item.name
			cellView?.imageView?.image = item.image
			return cellView
		***REMOVED***
		return nil
	***REMOVED***
	
	
***REMOVED***
