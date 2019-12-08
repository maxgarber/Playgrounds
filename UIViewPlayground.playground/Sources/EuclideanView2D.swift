import Foundation
import UIKit

let PI = CGFloat(3.1415926535897932384626433832795)

public func transpose(point p: CGPoint, in r: CGRect, to q: CGRect) -> CGPoint {
	let originalRelativeX = (p.x - r.minX) / (r.maxX - r.minX)
	let originalRelativeY = (p.y - r.minY) / (r.maxY - r.minY)
	let newX = (originalRelativeX * (q.maxX - q.minX)) + q.minX
	let newY = (originalRelativeY * (q.maxY - q.minY)) + q.minY
	return CGPoint(x: newX, y: newY)
}


public class EuclideanView2D: UIView {
	
	public var pointSet: EuclideanPointSet2D
	
	// #MARK: Axes
	public var xAxisStart: CGFloat { return pointSet.domain.lowerBound }
	public var xAxisStop: CGFloat { return pointSet.domain.upperBound }
	public var yAxisStart: CGFloat { return pointSet.range.lowerBound }
	public var yAxisStop: CGFloat { return pointSet.range.upperBound }
	
	public var xAxisLinePosition: CGFloat = 0.0	// position on the y axis, yAxisStart ≤ • ≤ yAxisStop
	public var yAxisLinePosition: CGFloat = 0.0	// position on the x axis, xAxisStart ≤ • ≤ xAxisStop
	
	public var xAxisLineWidth: CGFloat = 1.0
	public var xAxisLineColor: UIColor = UIColor.black
	public var yAxisLineWidth: CGFloat = 1.0
	public var yAxisLineColor: UIColor = UIColor.black
	public var pointColor: UIColor = UIColor.red
	public var pointSize: CGFloat = 3.0
	
	public var coordinateFrame: CGRect {
		return CGRect(
				x: CGFloat(xAxisStart),
				y: CGFloat(yAxisStart),
				width: CGFloat(xAxisStop - xAxisStart),
				height: CGFloat(yAxisStop - yAxisStart)
			)
	}
	public var frameBorderWidth: CGFloat = 1.0
	public var frameBorderColor: UIColor = UIColor.black
	
	// #MARK: - Component Drawing Functions
	func drawAxes(_ rect: CGRect) {
		let xAxisPath = UIBezierPath()
		let xAxisLinePositionScaled = ((xAxisLinePosition - yAxisStart) / (yAxisStop - yAxisStart)) * rect.height
		xAxisLineColor.setStroke()
		xAxisPath.lineWidth = CGFloat(xAxisLineWidth)
		xAxisPath.move(to: CGPoint(x: rect.minX, y: xAxisLinePositionScaled))
		xAxisPath.addLine(to: CGPoint(x: rect.maxX, y: xAxisLinePositionScaled))
		xAxisPath.stroke()
		
		let yAxisPath = UIBezierPath()
		let yAxisLinePositionScaled = ((yAxisLinePosition - xAxisStart) / (xAxisStop - xAxisStart)) * rect.width
		yAxisLineColor.setStroke()
		yAxisPath.lineWidth = CGFloat(yAxisLineWidth)
		yAxisPath.move(to: CGPoint(x: yAxisLinePositionScaled, y: rect.minY))
		yAxisPath.addLine(to: CGPoint(x: yAxisLinePositionScaled, y: rect.maxY))
		yAxisPath.stroke()
	}
	
	func drawSinglePoint(at point: CGPoint, in rect: CGRect, color: UIColor, radius: CGFloat) {
		let path = UIBezierPath()
		color.setStroke()
		color.setFill()
		let p = path.currentPoint
		path.move(to: point)
		path.addArc(withCenter: point, radius: radius, startAngle: 0.00, endAngle: 2*PI, clockwise: true)
		path.close()
		path.fill()
		path.stroke()
		path.move(to: p)
	}
	
	func drawPoints(connected: Bool, inFrame drawingFrame: CGRect) {
		if (pointSet.points.count == 0) { return }
		
		let pointsPath = UIBezierPath()
		pointColor.setStroke()
		pointsPath.lineWidth = CGFloat(pointSize)
		
		let transposedPoint = transpose(point: pointSet.points[0], in: self.coordinateFrame, to: drawingFrame)
		pointsPath.move(to: transposedPoint)
		
		pointsPath.lineCapStyle = .round
		pointsPath.lineJoinStyle = .round
		
		for point in pointSet.points {
			let p = transpose(point: point, in: self.coordinateFrame, to: drawingFrame)
			if (connected) { pointsPath.addLine(to: p) }
			pointsPath.move(to: p)
			pointsPath.stroke()
			drawSinglePoint(at: p, in: drawingFrame, color: pointColor, radius: pointSize/2)
		}
		
		
	}
	
	// #MARK: - Overrides
	public override func draw(_ rect: CGRect) {
		drawAxes(rect)
		drawPoints(connected: true, inFrame: rect)
	}
	
	public override init(frame: CGRect) {
		self.pointSet = EuclideanPointSet2D()
		super.init(frame:frame)
		self.backgroundColor = UIColor.white
	}
	
	public required init?(coder aDecoder: NSCoder) {
		self.pointSet = EuclideanPointSet2D()
		super.init(coder: aDecoder)
		self.backgroundColor = UIColor.white
	}
}


public class EuclideanView2DController : UIViewController {
	public override func loadView() {
		super.loadView()
	}
}


