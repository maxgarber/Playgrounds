import Foundation
import AppKit

extension MGOutlineViewController: NSOutlineViewDelegate {
	
	public func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
		if let item = item as? OutlineViewItem {
			return item.isGroup
		} else {
			return false
		}
	}
	
	public func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
		if let item = item as? OutlineViewItem {
			let uii = item.isGroup ? self.groupCellUII : self.dataCellUII
			
			if let cellView = outlineView.makeView(withIdentifier: uii, owner: self) as? NSTableCellView {
				cellView.textField?.stringValue = item.name
				if !item.isGroup {
					cellView.imageView?.image = item.image
				}
				return cellView
			}
		}
		return nil
	}
	
	
}

