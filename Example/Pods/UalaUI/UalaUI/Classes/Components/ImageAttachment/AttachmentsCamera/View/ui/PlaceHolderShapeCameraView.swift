import UIKit

class PlaceHolderShapeCameraView: UIView {
    
    var path: UIBezierPath!
    let strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var placeHolderType:AttachmentType?{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        if let type = self.placeHolderType{
            switch type{
            case .document, .identification:
                self.drawRectangle(rect)
            case .selfie:
                self.drawOval(rect)
            }
        }
        
    }
    
    func createShapeLayer(_ rect:CGRect)->CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = rect
        shapeLayer.path = self.path.cgPath
        shapeLayer.strokeColor = self.strokeColor.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        return shapeLayer
    }
    
    func drawRectangle(_ rect: CGRect){
        let rectView = UIView()
        rectView.frame = rect
        self.path = UIBezierPath(roundedRect: rect, cornerRadius: 8)
        rectView.layer.addSublayer(self.createShapeLayer(rect))
        self.addSubview(rectView)
    }
    
    func drawOval(_ rect: CGRect){
        let ovalView = UIView()
        ovalView.frame = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.height, height: rect.width)
        self.path = UIBezierPath(ovalIn: ovalView.frame)
        let radians = CGFloat(90 * Float.pi / 180)
        ovalView.transform = CGAffineTransform(rotationAngle: radians)
        ovalView.originX = 0
        ovalView.originY = 0
        ovalView.layer.addSublayer(self.createShapeLayer(rect))
        self.addSubview(ovalView)
    }
}
