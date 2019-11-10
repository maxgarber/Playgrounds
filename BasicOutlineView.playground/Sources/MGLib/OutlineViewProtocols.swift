import AppKit
import Cocoa
import Foundation


public protocol OutlineViewItem ***REMOVED***
	var name: String ***REMOVED*** get ***REMOVED***
	var image: NSImage? ***REMOVED*** get ***REMOVED***
	var children: [OutlineViewItem] ***REMOVED*** get ***REMOVED***
***REMOVED***


public protocol OutlineViewController: NSOutlineViewDataSource, NSOutlineViewDelegate ***REMOVED***
	var items: [OutlineViewItem] ***REMOVED*** get ***REMOVED***
***REMOVED***
