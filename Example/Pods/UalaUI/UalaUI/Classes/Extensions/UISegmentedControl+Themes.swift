//
//  UISegmentedControl+Themes.swift
//  UalaUI
//
//  Created by Josefina Perez on 30/01/2020.
//

import UIKit

public struct SegmentedControlStyle {
    
    let backgroundColor: UIColor
    let borderWidth: CGFloat
    let borderColor: UIColor
    let cornerRadius: CGFloat
    let tintColor: UIColor
    let selectedSegmentTintColor: UIColor
    let fontColor: UIColor
    let selectedSegmentFontColor: UIColor
}

public extension SegmentedControlStyle {
    
    static var normal: SegmentedControlStyle {
        return SegmentedControlStyle(backgroundColor: .clear, borderWidth: 0, borderColor: .white, cornerRadius: 2, tintColor: .clear, selectedSegmentTintColor: .white, fontColor: .white, selectedSegmentFontColor: UalaStyle.colors.cornflower)
    }
}

public extension UISegmentedControl {
    
    func customize(style: SegmentedControlStyle = .normal) {
        
        if #available(iOS 13.0, *) {
            backgroundColor = style.backgroundColor
            layer.borderWidth = style.borderWidth
            layer.borderColor = style.borderColor.cgColor
            layer.cornerRadius = style.cornerRadius
            tintColor = style.tintColor
            selectedSegmentTintColor = style.selectedSegmentTintColor
            setTitleTextAttributes([.foregroundColor: style.fontColor, .font: UIFont.regular(size: 13)], for: .normal)
            setTitleTextAttributes([.foregroundColor: style.selectedSegmentFontColor, .font: UIFont.regular(size: 13)], for: .selected)
        }
    }
}


