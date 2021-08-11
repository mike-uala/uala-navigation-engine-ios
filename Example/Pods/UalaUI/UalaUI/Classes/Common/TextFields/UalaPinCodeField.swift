//
//  UalaPinCodeField.swift
//  Uala
//
//  Created by Developer on 8/3/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class UalaPinCodeField: UIControl, UITextInputTraits {
    
    /** The text entered by user. */
    @IBInspectable open var text: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /** Length of the pin code */
    @IBInspectable open var length: Int = 4 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /** Color of the dots. */
    @IBInspectable open var color: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /** Color of the dots filled. */
    @IBInspectable open var colorFilled: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /** Diameter of the dots. */
    @IBInspectable open var diameter: CGFloat = 20.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /** Spacing between the dots. */
    @IBInspectable open var spacing: CGFloat = 16.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /** Line thickness. */
    @IBInspectable open var thickness: CGFloat = 2.0 {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsDisplay()
        }
    }
    
    /** Tells whether the pin code is empty. */
    open var isEmpty: Bool {
        return text.isEmpty
    }
    
    /** Tells whether all characters were entered. */
    open var isFilled: Bool {
        return text.count == length
    }
    
    // MARK: UITextInputTraits protocol properties
    open var autocapitalizationType = UITextAutocapitalizationType.none
    open var autocorrectionType = UITextAutocorrectionType.no
    open var spellCheckingType = UITextSpellCheckingType.no
    open var keyboardType = UIKeyboardType.numberPad
    open var keyboardAppearance = UIKeyboardAppearance.default
    open var returnKeyType = UIReturnKeyType.done
    open var enablesReturnKeyAutomatically = true

    // MARK: initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        addTarget(self, action: #selector(becomeFirstResponder), for: .touchUpInside)
    }
    
    // MARK: UIResponder
    override open var canBecomeFirstResponder: Bool {
        return true
    }
    
    fileprivate var accessoryView: UIView?
    
    override open var inputAccessoryView: UIView? {
        get {
            return accessoryView
        }
        set(value) {
            accessoryView = value
        }
    }
    
    // MARK: UIView
    override open var intrinsicContentSize: CGSize {
        let width = CGFloat(length) * (diameter + spacing) - spacing + thickness
        let height = diameter + thickness
        return CGSize(width: width, height: height)
    }
    
    override open func draw(_ rect: CGRect) {
        var origin = CGPoint(x: 3, y: 3)
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(thickness)
        
        // Draw circles
        for index in 0..<length {
            
            let isDotFilled = index < text.count
            if isDotFilled {
                
                let neworigin = CGPoint(x: origin.x - 3, y: origin.y - 3)
                let newwidth = diameter + thickness + 6
                let newheight = diameter + thickness + 6
                
                context?.setFillColor(colorFilled.cgColor)
                context?.setStrokeColor(colorFilled.cgColor)
                
                let dotRect = CGRect(origin: neworigin, size: CGSize(width: newwidth, height: newheight))
                context?.fillEllipse(in: dotRect)
            } else {
                context?.setFillColor(color.cgColor)
                context?.setStrokeColor(color.cgColor)
                
                let position = CGPoint(x: origin.x + thickness/2, y: origin.y + thickness/2)
                let dotRect = CGRect(origin: position, size: CGSize(width: diameter, height: diameter))
                context?.strokeEllipse(in: dotRect)
            }
            
            origin.x += diameter + spacing
        }
    }
    
    private func clearInfo() {
        text = ""
    }
    
    public func animate() {
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 30, -30, 30, 0]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = CFTimeInterval(0.3)
        animation.isAdditive = true
        animation.repeatCount = 0
        animation.beginTime = CACurrentMediaTime()
        layer.add(animation, forKey: "shake")
        
        clearInfo()
    }
}

// MARK: UIKeyInput
extension UalaPinCodeField : UIKeyInput {
    
    public var hasText: Bool {
        return !text.isEmpty
    }
    
    public func insertText(_ textToInsert: String) {
        if self.isEnabled && text.count + textToInsert.count <= length {
            text.append(textToInsert)
            sendActions(for: .editingChanged)
        }
    }
    
    public func deleteBackward() {
        if self.isEnabled && !text.isEmpty {
            text.remove(at: text.index(before: text.endIndex))
            sendActions(for: .editingChanged)
        }
    }
    
}
