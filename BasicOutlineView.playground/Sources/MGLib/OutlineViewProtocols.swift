import AppKit
import Cocoa
import Foundation


public protocol OutlineViewItem {
	var name: String { get }
	var image: NSImage? { get }
	var children: [OutlineViewItem] { get }
}


public protocol OutlineViewController: NSOutlineViewDataSource, NSOutlineViewDelegate {
	var items: [OutlineViewItem] { get }
}
