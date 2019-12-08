//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

let view = EuclideanView2D()
let viewController = EuclideanView2DController()

let dataset = EuclideanPointSet2D()
for i in -9...9 {
	let j = CGFloat.random(in: -10.0...10.0)
	let p = CGPoint(x: CGFloat(i), y: j)
	dataset.points.append(p)
}
view.pointSet = dataset

viewController.preferredContentSize = CGSize(width: 640, height: 480)
viewController.view = view
PlaygroundPage.current.liveView = viewController


