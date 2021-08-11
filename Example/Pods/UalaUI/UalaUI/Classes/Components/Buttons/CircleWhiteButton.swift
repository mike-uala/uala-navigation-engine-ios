//
//  CircleButton.swift
//  UalaUI
//
//  Created by Josefina Perez on 19/11/2019.
//

import UIKit

public class CircleWhiteButton: UIButton {
    
    override public var isHighlighted: Bool {
        didSet {
            layer.borderColor = isHighlighted ? UalaStyle.colors.cornflower.cgColor : UIColor.clear.cgColor
            layer.borderWidth = isHighlighted ? 1 : 0
        }
    }
    
    public func setup(title: String) {
        setTitle(title, for: .normal)
        customize(style: .white)
        cornerRadius(radius: frame.width / 2)
        
        let shadowView = UIView(frame: frame)
        shadowView.backgroundColor = .white
        shadowView.cornerRadius(radius: shadowView.frame.width / 2)
        shadowView.dropShadow()
        
        superview?.insertSubview(shadowView, belowSubview: self)
    }
}
