import Foundation
import UIKit

public class EuclideanPointSet2D {
	
	public var points: [CGPoint] = []
	
	public init() {
		
	}
	
	public var domain: ClosedRange<CGFloat> {
		if (points.count == 0) { return (0...0) }
		var lowerBound: CGFloat = points[0].x
		var upperBound: CGFloat = points[0].x
		for p in points {
			if (p.x < lowerBound) { lowerBound = p.x }
			if (p.x > upperBound) { upperBound = p.x }
		}
		return lowerBound...upperBound
	}
	
	public var range: ClosedRange<CGFloat> {
		if (points.count == 0) { return (0...0) }
		var lowerBound: CGFloat = points[0].y
		var upperBound: CGFloat = points[0].y
		for p in points {
			if (p.y < lowerBound) { lowerBound = p.y }
			if (p.y > upperBound) { upperBound = p.y }
		}
		return lowerBound...upperBound
	}
}

