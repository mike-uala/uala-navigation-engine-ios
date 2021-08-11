//
//  UIView.swift
//  Uala
//
//  Created by Developer on 7/14/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

// MARK: Frame Extensions

public extension UIView {
    
    var originX: CGFloat {
        get {
            return self.frame.origin.x
        } set (value) {
            self.frame = CGRect (x: value, y: originY, width: width, height: self.height)
        }
    }
    
    var originY: CGFloat {
        get {
            return self.frame.origin.y
        } set (value) {
            self.frame = CGRect (x: originX, y: value, width: width, height: height)
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        } set (value) {
            self.frame = CGRect (x: self.originX, y: originY, width: value, height: height)
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        } set (value) {
            self.frame = CGRect (x: originX, y: originY, width: width, height: value)
        }
    }
    
    var left: CGFloat {
        get {
            return originX
        } set (value) {
            originX = value
        }
    }
    
    var right: CGFloat {
        get {
            return originX + width
        } set (value) {
            originX = value - width
        }
    }
    
    var top: CGFloat {
        get {
            return originY
        } set (value) {
            originY = value
        }
    }
    
    var bottom: CGFloat {
        get {
            return originY + height
        } set (value) {
            originY = value - height
        }
    }
    
    func leftWithOffset (_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    func rightWithOffset (_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    func topWithOffset (_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    func bottomWithOffset (_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    func cornerRadius(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func currentFirstResponder() -> UIResponder? {
        
        if isFirstResponder {
            return self
        }
        
        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        
        return nil
    }
    
    func addBorder(_ width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    func addBorderBottom(size: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.height - size, width: self.width, height: size)
        layer.addSublayer(border)
    }
    
    func snapshot() -> UIImage? {
        
        UIGraphicsBeginImageContext(self.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func autoPinToEdges(of view: UIView) {
        self.autoPinEdge(.left, to: .left, of: view)
        self.autoPinEdge(.right, to: .right, of: view)
        self.autoPinEdge(.top, to: .top, of: view)
        self.autoPinEdge(.bottom, to: .bottom, of: view)
    }
    
    func addBotSeparator(with insets: UIEdgeInsets) {
        let line = UIView()
        line.backgroundColor = UalaStyle.colors.grey50
        self.addSubview(line)
        
        line.autoPinEdgesToSuperviewEdges(with: insets, excludingEdge: .top)
        line.autoSetDimension(.height, toSize: 1)
    }
    
    func addDashedBorder() {
        let dashedBorder = CAShapeLayer()
        dashedBorder.strokeColor = UalaStyle.colors.grey60.cgColor
        dashedBorder.lineDashPattern = [7.5, 7.5]
        dashedBorder.frame = self.bounds
        dashedBorder.fillColor = nil
        dashedBorder.path = UIBezierPath(rect: self.bounds).cgPath
        self.layer.addSublayer(dashedBorder)
    }
    
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}

public extension UIView {
    
    // OUTPUT 1
    
    func dropShadow(shadowOpacity: Float = 10, shadowOffset: CGSize = .zero, color: UIColor = UalaStyle.colors.grey50.withAlphaComponent(0.5), radius: CGFloat = 4, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = radius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(offsetX: CGFloat, offsetY: CGFloat, color: UIColor, opacity: Float, radius: CGFloat, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    func copyView() -> UIView? {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as? UIView
    }
}

public extension UIView {
    
    func loadNib() {
        guard let nibName = NSStringFromClass(classForCoder).components(separatedBy: ".").last else { return }
        let bundle = Bundle(for: type(of: self))        
        bundle.loadNibNamed(nibName, owner: self, options: nil)
    }
    
    static func loadFromXib<T>(withOwner: Any? = nil, options: [AnyHashable: Any]? = nil) -> T where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: withOwner, options: options as? [UINib.OptionsKey: Any]).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func addConstraintsToFit(view: UIView) {
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                                 options: NSLayoutConstraint.FormatOptions(),
                                                                                 metrics: nil,
                                                                                 views: ["view": view])
        addConstraints(verticalConstraints)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                                   options: NSLayoutConstraint.FormatOptions(),
                                                                                   metrics: nil,
                                                                                   views: ["view": view])
        addConstraints(horizontalConstraints)
    }
}

public extension UIView {
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

public extension UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

public extension UIView {
    func findParentViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findParentViewController()
        } else {
            return nil
        }
    }
}
