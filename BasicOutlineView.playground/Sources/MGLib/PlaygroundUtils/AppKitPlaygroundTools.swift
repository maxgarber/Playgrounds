//
//	MGLib: PlaygroundNibTools
//	Created by Max Garber on 2019/05/21
//

import AppKit
import Foundation
import PlaygroundSupport


/// Loads a nib and its objects with the given controller/owner:
/// - Parameter nibName: The name of a .xib file (minus the extension) in the "main bundle"
/// - Parameter controller: The controller to manage the nib's contents (must be an NSViewController/subclass)
/// - Returns: A boolean which is true on success, false otherwise
public func loadViewFromNib (_ nibName: String, withOwner controller: NSViewController) -> Bool {
	var topLevelObjects: NSArray?
	if (Bundle.main.loadNibNamed(NSNib.Name(nibName), owner: controller, topLevelObjects: &topLevelObjects)) {
		if let views = ((topLevelObjects as? [Any])?.filter({$0 is NSView}) as? [NSView]), views.count > 0 {
			controller.view = views[0]
			return true
		}
	}
	return false
}


/// Loads a nib and its objects with the given controller/owner:
/// - Parameter nibName: The name of a .xib file (minus the extension) in the "main bundle"
/// - Parameter controller: The NSWindowController/subclass instance to manage the nib contents
/// - Returns: A boolean which is true if successful, false otherwise
public func loadWindowFromNib(_ nibName: String, owner controller: NSWindowController) -> Bool {
	var topLevelObjects: NSArray?
	if (Bundle.main.loadNibNamed(NSNib.Name(nibName), owner: controller, topLevelObjects: &topLevelObjects)) {
		if let windows = ((topLevelObjects as? [Any])?.filter({$0 is NSWindow}) as? [NSWindow]), windows.count > 0 {
			controller.window = windows[0]
			return true
		}
	}
	return false
}


/// Displays a view controller's content in the Playground's live view:
/// - Parameter controller: an NSViewController/subclass which has been given a view to control
/// - Parameter xi: a Boolean that determines whether the execution environment is allowed to continue indefinitely
public func presentViewForController (_ controller: NSViewController, executeIndefinitely xi: Bool = true) {
	PlaygroundPage.current.liveView = controller
	PlaygroundPage.current.needsIndefiniteExecution = xi
}


/// Loads a nib file's contents, pairing windows and designated controllers and displaying the contents thereof:
/// - Parameter W: NSWindowController or a subclass of it
/// - Parameter nibFileName: a string, the name of a .xib file (minus the extension) in the "main bundle", and
/// - Returns: an array of window controllers, whose windows were found as top-level objects in the nib, and which have been displayed
/// - Note: Loads the nib file's objects, and for every top-level object that is an NSWindow or subclass:
/// 	1. instantiates a window controller of class W
/// 	2. assignes the object found as its window
/// 	3. tells the controller to display the window
/// 	4. adds the controller to the array of controllers to be returned to the user
public func displayWindowsInNibWithControllerInstancessOfClass<W: NSWindowController>(_ nibFileName: String) -> [W] {
	var windowControllers: [W] = []
	var topLevelObjects: NSArray?
	if (Bundle.main.loadNibNamed(NSNib.Name(nibFileName), owner: nil, topLevelObjects: &topLevelObjects)) {
		if let windows = ((topLevelObjects as? [Any])?.filter({$0 is NSWindow}) as? [NSWindow]), windows.count > 0 {
			for win in windows {
				let controller = W()
				controller.window = win
				controller.showWindow(nil)
				windowControllers.append(controller)
			}
		}
	}
	return windowControllers
}
