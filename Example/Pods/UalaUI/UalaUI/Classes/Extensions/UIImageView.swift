//
//  UIImageView.swift
//  Uala
//
//  Created by Nicolas on 8/8/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
    func setImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.2 : 0.0
        
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve], animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 0
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            
            UIView.transition(with: self, duration: duration + 0.2, options: [.transitionCrossDissolve], animations: {  [weak self] in
                guard let self = self else { return }
                
                self.alpha = 1
                self.image = image
            })
        }
    }
}

public extension UIImageView {
    
    func setCircle() {
        if self.width != self.height {
            self.width = self.height
        }
        self.cornerRadius(radius: self.width/2)
    }
    
    func setImage(string: String?) {
        setImage(string: string, color: nil, circular: false, textAttributes: nil)
    }
    
    func setImage(string: String?, color: UIColor?) {
        setImage(string: string, color: color, circular: false, textAttributes: nil)
    }
    
    func setImage(string: String?, color: UIColor?, circular: Bool) {
        setImage(string: string, color: color, circular: circular, textAttributes: nil)
    }
    
    func setImage(string: String?, color: UIColor?, circular: Bool, textAttributes: [NSAttributedString.Key : Any]?) {
        var displayString = ""
        if let string = string {
            displayString = string.shortString()
        }
        
        guard let imageColor = color != nil ? color : .random else { return }
        self.image = self.imageSnap(text: displayString as String, color: imageColor, circular: circular, textAttributes: textAttributes)
    }
    
    private func imageSnap(text: String?, color: UIColor, circular: Bool, textAttributes: [NSAttributedString.Key : Any]?) -> UIImage? {
        let scale: Float = Float(UIScreen.main.scale)
        var size: CGSize = self.bounds.size
        if contentMode == .scaleToFill || contentMode == .scaleAspectFill || contentMode == .scaleAspectFit || contentMode == .redraw {
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        if let context = UIGraphicsGetCurrentContext() {
            
            if circular {
                let path = CGPath(ellipseIn: self.bounds, transform: nil)
                context.addPath(path)
                context.clip()
            }
            
            // Fill
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x:0, y:0, width:size.width, height:size.height))
        }
        
        // Text
        if let text = text {
            var textAttributes = textAttributes
            if textAttributes == nil {
                textAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15.0)]
            }
            let textSize: CGSize = text.size(withAttributes: textAttributes)
            let bounds: CGRect = self.bounds
            text.draw(in: CGRect(x:bounds.size.width/2 - textSize.width/2, y:bounds.size.height/2 - textSize.height/2, width:textSize.width, height:textSize.height), withAttributes: textAttributes)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
        
    }
}

public extension UIImageView {
    
    func downloadImage(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: (() -> Void)? = nil) {
        contentMode = mode
        self.kf.setImage(with: url, placeholder: image)
    }
    
    func downloadImage(urlString: String, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: (() -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        downloadImage(url: url, contentMode: mode, completion: completion)
        
    }
    
    func downloadImage(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: @escaping CompletionHandler) {
        contentMode = mode
        self.kf.setImage(with: url, placeholder: image, completionHandler: completion)
    }
}

