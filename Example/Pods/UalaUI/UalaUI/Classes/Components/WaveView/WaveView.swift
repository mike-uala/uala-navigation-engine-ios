import UIKit

protocol Scrollable {
    func didScroll(ratio: CGFloat)
}

public class WaveView: UIView {
    
    var waveHeight: CGFloat = 0
    var backWave = CAShapeLayer()
    var frontWave = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        frontWave.path = wavePath(WavePathGenerator.firstWave())
        frontWave.fillColor = UIColor.white.cgColor
        layer.addSublayer(frontWave)

        backWave.path = wavePath(WavePathGenerator.secondWave())
        backWave.fillColor = UIColor(white: 1, alpha: 0.5).cgColor
        layer.addSublayer(backWave)
    }
    
    public func deletePaths() {
        backWave.removeFromSuperlayer()
        frontWave.removeFromSuperlayer()
    }
    
    public func setSingleWave() {
        backWave.removeFromSuperlayer()
        frontWave.path = wavePath(WavePathGenerator.singleWave())
    }
    
    func wavePath(_ instructions: [PathInstruction], _ scale: CGFloat = 1) -> CGPath {        
        let bezierPath = UIBezierPath()
        instructions.forEach({ $0.apply(path: bezierPath, scale: scale) })
        bezierPath.close()
        
        fit(bezierPath, into: frame)
        waveHeight = bezierPath.bounds.origin.y + bezierPath.bounds.size.height
        translate(bezierPath)
        
        return bezierPath.cgPath
    }
    
    func translate(_ path: UIBezierPath) {
        let translate = CGAffineTransform(translationX: 0, y: frame.size.height - waveHeight)
        path.apply(translate)
    }
    
    func fit(_ path: UIBezierPath, into: CGRect) {
        let bounds = path.bounds
        let swRate = UIScreen.main.bounds.width/bounds.width
        let shRate = into.size.height/bounds.height
        let factor = min(swRate, max(shRate, 0.0))
        path.apply(CGAffineTransform(scaleX: factor, y: factor))
    }
}

extension WaveView: Scrollable {
    func didScroll(ratio: CGFloat) {
        frontWave.path = wavePath(WavePathGenerator.firstWave(), ratio)
        backWave.path = wavePath(WavePathGenerator.secondWave(), ratio)
    }
}
