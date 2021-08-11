//
//  RoundedButtonWithIcon.swift
//  Uala
//
//  Created by Alejandro Zalazar on 28/05/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundedButtonWithIcon: UIButton {
    
    override public func draw(_ rect: CGRect) {
         super.draw(rect)
        self.setUpUI()
    }

    func setUpUI(){
        self.contentHorizontalAlignment = .left
        self.titleEdgeInsets.left = 40.0
        self.imageEdgeInsets.left = 20.0
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = self.tintColor.cgColor
    }
    
    public func hiddenIcon(){
        setImage(nil, for: .normal)
    }
}
