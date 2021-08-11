//
//  LoaderGradientBar.swift
//  Uala
//
//  Created by Nicolas on 31/01/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import Shimmer

public class LoaderGradientBar: FBShimmeringView {
    var gradientView: GradientView!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeUI()
    }
    
    private func customizeUI() {
        self.backgroundColor = .clear
        self.isHidden = true
        gradientView = GradientView(frame: self.frame)
        gradientView.startColor = UalaStyle.colors.paleGrey
        gradientView.endColor = .white
        
        self.addSubview(gradientView)
        self.contentView = gradientView
    }
    
    public func isLoading(_ isLoading: Bool) {
        self.isHidden = !isLoading
        self.isShimmering = isLoading
        
    }
}
