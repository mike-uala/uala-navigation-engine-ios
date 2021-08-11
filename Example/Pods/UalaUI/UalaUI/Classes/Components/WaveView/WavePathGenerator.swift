protocol PathInstruction {
    func apply(path: UIBezierPath, scale: CGFloat)
}

struct MoveInstruction: PathInstruction {
    
    var point: CGPoint
    
    func apply(path: UIBezierPath, scale: CGFloat) {
        path.move(to: CGPoint(x: point.x, y: point.y * scale))
    }
}

struct LineInstruction: PathInstruction {
    
    var point: CGPoint
    
    func apply(path: UIBezierPath, scale: CGFloat) {
        path.addLine(to: CGPoint(x: point.x, y: point.y * scale))
    }
}

struct CubicInstruction: PathInstruction {
    
    var point: CGPoint
    var controlPoint1: CGPoint
    var controlPoint2: CGPoint
    
    func apply(path: UIBezierPath, scale: CGFloat) {
        path.addCurve(to: CGPoint(x: point.x, y: point.y * scale),
                      controlPoint1: CGPoint(x: controlPoint1.x, y: controlPoint1.y * scale),
                      controlPoint2: CGPoint(x: controlPoint2.x, y: controlPoint2.y * scale))
    }
}

class WavePathGenerator {
    
    static func firstWave() -> [PathInstruction] {
        return [
            MoveInstruction(point: CGPoint(x: 45.28, y: 0.5)),
            CubicInstruction(point: CGPoint(x: 142.1, y: 19.88), controlPoint1: CGPoint(x: 69.06, y: 0.5), controlPoint2: CGPoint(x: 107.85, y: 19.88)),
            CubicInstruction(point: CGPoint(x: 238.47, y: 4), controlPoint1: CGPoint(x: 176.35, y: 19.88), controlPoint2: CGPoint(x: 210.88, y: 4)),
            CubicInstruction(point: CGPoint(x: 314.91, y: 17.5), controlPoint1: CGPoint(x: 266.06, y: 4), controlPoint2: CGPoint(x: 290.4, y: 17.5)),
            CubicInstruction(point: CGPoint(x: 360, y: 7.26), controlPoint1: CGPoint(x: 339.41, y: 17.5), controlPoint2: CGPoint(x: 346.46, y: 7.26)),
            LineInstruction(point: CGPoint(x: 360, y: 24)),
            LineInstruction(point: CGPoint(x: 0, y: 24)),
            LineInstruction(point: CGPoint(x: 0, y: 6.91)),
            CubicInstruction(point: CGPoint(x: 45.28, y: 0.5), controlPoint1: CGPoint(x: 0, y: 6.91), controlPoint2: CGPoint(x: 21.5, y: 0.5))
        ]
    }
    
    static func secondWave() -> [PathInstruction] {
        return [
            MoveInstruction(point: CGPoint(x: 318, y: 0.31)),
            CubicInstruction(point: CGPoint(x: 225.37, y: 22.99), controlPoint1: CGPoint(x: 291.65, y: 0.31), controlPoint2: CGPoint(x: 259.73, y: 22.99)),
            CubicInstruction(point: CGPoint(x: 128.7, y: 0.31), controlPoint1: CGPoint(x: 191.01, y: 22.99), controlPoint2: CGPoint(x: 166.9, y: 0.31)),
            CubicInstruction(point: CGPoint(x: 32.5, y: 27.5), controlPoint1: CGPoint(x: 90.5, y: 0.31), controlPoint2: CGPoint(x: 56.47, y: 27.5)),
            CubicInstruction(point: CGPoint(x: 0.27, y: 20), controlPoint1: CGPoint(x: 8.53, y: 27.5), controlPoint2: CGPoint(x: 0.63, y: 20)),
            CubicInstruction(point: CGPoint(x: 0, y: 33), controlPoint1: CGPoint(x: 0.09, y: 20), controlPoint2: CGPoint(x: 0, y: 24.33)),
            LineInstruction(point: CGPoint(x: 360, y: 33)),
            LineInstruction(point: CGPoint(x: 360, y: 8.5)),
            CubicInstruction(point: CGPoint(x: 318, y: 0.31), controlPoint1: CGPoint(x: 360, y: 7.93), controlPoint2: CGPoint(x: 344.35, y: 0.31))
        ]
    }
    
    static func singleWave() -> [PathInstruction] {
        return [
            MoveInstruction(point: CGPoint(x: 73.96, y: 175.94)),
            CubicInstruction(point: CGPoint(x: 182, y: 190.38), controlPoint1: CGPoint(x: 101.6, y: 177.97), controlPoint2: CGPoint(x: 135.47, y: 190.38)),
            CubicInstruction(point: CGPoint(x: 299.42, y: 175.94), controlPoint1: CGPoint(x: 225.3, y: 190.38), controlPoint2: CGPoint(x: 245.88, y: 181.41)),
            CubicInstruction(point: CGPoint(x: 374.99, y: 179.58), controlPoint1: CGPoint(x: 324.6, y: 173.38), controlPoint2: CGPoint(x: 368.48, y: 179.58)),
            CubicInstruction(point: CGPoint(x: 374.99, y: 204), controlPoint1: CGPoint(x: 374.99, y: 179.58), controlPoint2: CGPoint(x: 374.99, y: 187.72)),
            LineInstruction(point: CGPoint(x: 0, y: 204)),
            CubicInstruction(point: CGPoint(x: 0, y: 183.78), controlPoint1: CGPoint(x: 0, y: 190.52), controlPoint2: CGPoint(x: 0, y: 183.78)),
            CubicInstruction(point: CGPoint(x: 73.96, y: 175.94), controlPoint1: CGPoint(x: 15.53, y: 180.14), controlPoint2: CGPoint(x: 46.32, y: 173.92))
        ]
    }
}
