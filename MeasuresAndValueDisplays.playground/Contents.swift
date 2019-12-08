//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .darkGray

        
        let backingRect = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        backingRect.layer.cornerRadius = 25
        backingRect.backgroundColor = .red
        
        
//        let label = UILabel()
//        label.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
//        label.text = "Hello World!"
//        label.textColor = .white
//        label.backgroundColor = .blue
//        label.sizeToFit()
//        label.layer.cornerRadius = 25
//        label.setNeedsDisplay()
        
//        let mask = CAShapeLayer()
//        // Set its frame to the view bounds
//        mask.frame = label.bounds
//        // Build its path with a smoothed shape
//        mask.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: 20.0).cgPath
//        // Apply the mask to the view
//        label.layer.mask = mask
        
        view.addSubview(backingRect)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
