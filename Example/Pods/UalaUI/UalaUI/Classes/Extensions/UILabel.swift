//
//  UILabel.swift
//  Uala
//
//  Created by Developer on 7/21/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public extension UILabel {
    
    func getEstimatedSize (
        _ width: CGFloat = CGFloat.greatestFiniteMagnitude,
        height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }
    
    func getEstimatedHeight () -> CGFloat {
        return sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    func getEstimatedWidth () -> CGFloat {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)).width
    }
    
    func fitHeight () {
        self.height = getEstimatedHeight()
    }
    
    func fitWidth () {
        self.width = getEstimatedWidth()
    }
    
    func fitSize () {
        self.fitWidth()
        self.fitHeight()
        sizeToFit()
    }
    
    // agrega espacio entre linea
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString: NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func setShadow(opacity: Float, radius: CGFloat ,color: CGColor ){
        self.layer.shadowColor = color
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.masksToBounds = false
    }
    
    func setTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(.kern, value: spacing, range: NSRange(location: 0, length: self.text!.count))
        self.attributedText = attributedString
    }
}
