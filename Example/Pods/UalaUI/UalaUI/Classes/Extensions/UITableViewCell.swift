//
//  UITableViewCell.swift
//  Uala
//
//  Created by Nicolas on 1/8/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

extension UITableViewCell: NibLoadableView { }

extension UITableViewCell: ReusableView { }

public extension UITableViewCell {
    func clearInit() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func animateTapTransform(transform: CGAffineTransform = CGAffineTransform(scaleX: 0.95, y: 0.95),
                             completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = transform
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) { self.transform = CGAffineTransform.identity }
            completion?()
        })
    }
    
    func animateWillDisplayCell(transform: CATransform3D, delayForIndex: Double, completion: (() -> Void)? = nil) {
        self.layer.transform = transform
        self.alpha = 0
        
        UIView.animate(withDuration: 1.0, delay: delayForIndex, options: UIView.AnimationOptions.transitionFlipFromBottom, animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
}

