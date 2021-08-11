//
//  GradientView.swift
//  Uala
//
//  Created by Nelson Domínguez on 18/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UIKit

public enum GradientOrientation: Int {
    case vertical = 0, horizontal = 1
    
    init(safeRawValue: Int) {
        self = GradientOrientation(rawValue: safeRawValue) ?? .horizontal
    }
}

@IBDesignable public class GradientView: UIView {

    @IBInspectable public var startColor: UIColor = UalaStyle.colors.blue50 {
        didSet {
            configureView()
        }
    }
    
    @IBInspectable public var endColor: UIColor = UalaStyle.colors.blue30 {
        didSet {
            configureView()
        }
    }
    
    @IBInspectable public var orientation: Int = 1 {
        didSet {
            configureView()
        }
    }
    
    public var locations: [NSNumber] = [] {
        didSet {
            guard let gradientLayer = layer as? CAGradientLayer else { return }
            gradientLayer.locations = locations
        }
    }
    
    private var gradientOrientation: GradientOrientation {
        return GradientOrientation(safeRawValue: orientation)
    }

    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    public override func tintColorDidChange() {
        super.tintColorDidChange()
        configureView()
    }

    private func configureView() {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        
        if gradientOrientation == .vertical {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

}
