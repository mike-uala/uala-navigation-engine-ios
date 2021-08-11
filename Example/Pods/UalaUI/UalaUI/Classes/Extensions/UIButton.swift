//
//  UIButton.swift
//  Uala
//
//  Created by Nicolas on 8/8/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

extension UIButton {
    
    open func setCircle() {
        setCircular(circular: true)
    }
    
    open func setButton(string: String?) {
        setButton(string: string, color: nil, circular: false, textColor: nil, font: nil)
    }
    
    open func setButton(string: String?, color: UIColor?) {
        setButton(string: string, color: nil, circular: false, textColor: nil, font: nil)

    }
    
    open func setButton(string: String?, color: UIColor?, circular: Bool) {
        setButton(string: string, color: color, circular: circular, textColor: nil, font: nil)

    }
    
    open func setButton(string: String?, color: UIColor?, circular: Bool, textColor: UIColor?, font: UIFont?) {
        var displayString = ""
        if let string = string {
            displayString = string.shortString()
        }
        if let color = color {
            self.buttonSnap(text: displayString as String, color: color, circular: circular, textColor: textColor, font: font)
        } else {
            self.buttonSnap(text: displayString as String, color: .random, circular: circular, textColor: textColor, font: font)
        }
    }
    
    open func setTitleWithOutAnimation(_ string: String?, for newState:UIControl.State) {
        UIView.setAnimationsEnabled(false)

        setTitle(string, for: newState)

        layoutIfNeeded()
        UIView.setAnimationsEnabled(true)
    }
    
    private func setCircular(circular: Bool) {
        if circular {
            layer.cornerRadius = 0.5 * bounds.size.width
            clipsToBounds = true
        }
    }
    
    private func buttonSnap(text: String?, color: UIColor, circular: Bool, textColor: UIColor?, font: UIFont?) {
        setCircular(circular: circular)
        
        // Fill
        backgroundColor = color
        
        // Text
        if let text = text {
            var textc = UIColor.white
            var newfont = UIFont.regular(size:15)
            if let tColor = textColor {
                textc = tColor
            }
            if let font = font {
                newfont = font
            }
            setTitleColor(textc, for: .normal)
            titleLabel?.font = newfont
            setTitle(text, for: .normal)
        }
    }
}

public extension UIButton {
    func downloadImage(url: URL, controlState state: UIControl.State = .normal, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: (() -> Void)? = nil) {
        self.imageView?.contentMode = mode
        self.kf.setImage(with: url, for: state)
    }
}
