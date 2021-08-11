//
//  ProgressView.swift
//  Uala
//
//  Created by Nicolas on 05/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//
import UIKit

public class ProgressView: UIView, CAAnimationDelegate {
    
    let circularLayer = CAShapeLayer()
    let strokeAnimationGroup = CAAnimationGroup()
    
    let inAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        return animation
    }()
    
    let outAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        return animation
    }()
    
    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = 2 * Double.pi
        animation.duration = 2.0
        animation.repeatCount = MAXFLOAT
        
        return animation
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()

    }
    
    private func initView() {
        circularLayer.lineWidth = 4.0
        circularLayer.fillColor = nil
        layer.addSublayer(circularLayer)

    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circularLayer.lineWidth / 2
        
        let arcPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi/2 + (2 * Double.pi)), clockwise: true)
                
        circularLayer.position = center
        circularLayer.path = arcPath.cgPath
        
        circularLayer.add(rotationAnimation, forKey: "rotateAnimation")
    }
    
    public func startAnimation(withColor color: CGColor = UIColor.white.cgColor) {
        circularLayer.removeAnimation(forKey: "strokeAnimation")
        
        circularLayer.strokeColor = color
        strokeAnimationGroup.duration = 1.0 + outAnimation.beginTime
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.animations = [inAnimation, outAnimation]
        strokeAnimationGroup.delegate = self
        
        circularLayer.add(strokeAnimationGroup, forKey: "strokeAnimation")
    }
    
    public func stopAnimation() {
        circularLayer.removeAllAnimations()
    }
    
}
