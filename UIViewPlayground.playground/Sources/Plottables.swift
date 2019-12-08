import Foundation
import UIKit

let W: Double = 640
let H: Double = 480
let M: Double = 100
let N: Int = 512


public typealias CoordinatePair2D = (ordinate: Double, abscissa: Double)

public protocol Plottable2D {
	
	var points: [CoordinatePair2D] { get set }
	var ordinateRange: ClosedRange<Double> { get }
	var abscissaRange: ClosedRange<Double> { get }
	
}


public class DataSetPlottable2D: Plottable2D {
	
	public var points: [CoordinatePair2D] = [CoordinatePair2D]()
	
	public var ordinateRange: ClosedRange<Double> {
		if (self.points.count > 0) {
			var min = points[0].ordinate
			var max = points[0].ordinate
			for p in points {
				if (p.ordinate > max) { max = p.ordinate }
				if (p.ordinate < min) { min = p.ordinate }
			}
			return min...max
		} else {
			return 0.0 ... 0.0
		}
	}
	
	public var abscissaRange: ClosedRange<Double> {
		if (self.points.count > 0) {
			var min = points[0].abscissa
			var max = points[0].abscissa
			for p in points {
				if (p.abscissa > max) { max = p.abscissa }
				if (p.abscissa < min) { min = p.abscissa }
			}
			return min...max
		} else {
			return 0.0 ... 0.0
		}
	}
	
	public init () {}
}

func transform(_ point: CGPoint, in rect: CGRect, to newRect: CGRect) -> CGPoint {
	
	let xInitial = point.x - rect.minX
	let yInitial = point.y - rect.minY
	
	let xScaleInitial = (rect.maxX - rect.minX)
	let yScaleInitial = (rect.maxY - rect.minY)
	
	let xScaleFinal = (newRect.maxX - newRect.minX)
	let yScaleFinal = (newRect.maxY - newRect.minY)
	
	let newX = ((xInitial / xScaleInitial) * xScaleFinal) + newRect.minX
	let newY = ((yInitial / yScaleInitial) * yScaleFinal) + newRect.minY
	
	return CGPoint(x: newX, y: newY)
}


class CartesianPlot2D: UIView {
	
	let hAxisLineWidth = 3.0
	let vAxisLineWidth = 3.0
	let dataPointSize = 5.0
	var dimensions: (width: Double, height: Double)
	
	var dataPoints = DataSetPlottable2D()
	
	override init(frame: CGRect) {
		dimensions.width = Double(W)
		dimensions.height = Double(H)
		super.init(frame:frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		dimensions.width = aDecoder.decodeDouble(forKey: "dimensions.width")
		dimensions.height = aDecoder.decodeDouble(forKey: "dimensions.height")
		super.init(coder: aDecoder)
	}
	
	func drawAxes(_ rect: CGRect) {
		UIColor.black.setStroke()
		
		// horizontal
		let hAxisPath = UIBezierPath()
		hAxisPath.lineWidth = CGFloat(hAxisLineWidth)
		hAxisPath.move(to: CGPoint(x: 0.0, y: (rect.height / 2)))
		hAxisPath.addLine(to: CGPoint(x: rect.width, y: (rect.height / 2)))
		hAxisPath.stroke()
		
		// vertical
		let vAxisPath = UIBezierPath()
		vAxisPath.lineWidth = CGFloat(vAxisLineWidth)
		vAxisPath.move(to: CGPoint(x: (rect.width/10), y: 0))
		vAxisPath.addLine(to: CGPoint(x: (rect.width/10), y:(rect.height)))
		vAxisPath.stroke()
	}
	
	func drawPlotPoints(connected: Bool, size: Double, color: UIColor, in rect: CGRect) {
		
		//		let diagonal = UIBezierPath()
		//		UIColor.red.setStroke()
		//		diagonal.lineWidth = 3.0
		//		diagonal.move(to: CGPoint(x: 0.0, y: 0.0))
		//		diagonal.addLine(to: CGPoint(x: rect.width, y: rect.height))
		//		diagonal.stroke()
		
		let horizontalOffset = dataPoints.ordinateRange.lowerBound
		let verticalOffset = dataPoints.abscissaRange.lowerBound
		let horizontalScale = (dataPoints.ordinateRange.upperBound - dataPoints.ordinateRange.lowerBound) / dimensions.width
		let verticalScale = (dataPoints.abscissaRange.upperBound - dataPoints.abscissaRange.lowerBound) / dimensions.height
		
		func translate(ordinate: Double, abscissa: Double) -> (ordinate: Double, abscissa: Double) {
			let o = (ordinate - horizontalOffset) * horizontalScale
			let a = (abscissa - verticalOffset) * verticalScale
			return (ordinate: o, abscissa: a)
		}
		
		print(translate(ordinate: 0.0, abscissa: 0.0))
		
		let dataPath = UIBezierPath()
		color.setStroke()
		dataPath.lineWidth = CGFloat(dataPointSize)
		
		for (i,point) in dataPoints.points.enumerated() {
			let translation = translate(ordinate: point.ordinate, abscissa: point.abscissa)
			print(translation)
			
			let translatedPoint = CGPoint(x: translation.ordinate, y: translation.abscissa)
			print(translatedPoint)
			
			if (i == 0) {
				dataPath.move(to: translatedPoint)
			} else {
				dataPath.addLine(to: translatedPoint)
			}
			if (i < dataPoints.points.count - 1) {
				dataPath.move(to: translatedPoint)
			}
			dataPath.stroke()
		}
	}
	
	override func draw(_ rect: CGRect) {
		drawAxes(rect)
		drawPlotPoints(connected: true, size: 3.0, color: UIColor.red, in: rect)
	}
}
