//
//  PageView.swift
//  Uala
//
//  Created by Nicolas on 12/03/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit
import UalaCore

public class PageView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    private func customizeUI() {
        self.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.customize(style: .header)
        titleLabel.textAlignment = .center
        
        subTitleLabel.customize(style: .regularWarmGreyTwoLeft(size: 15))
        subTitleLabel.textAlignment = .center
    }
    
    public func configure(with page: TutorialPageModel, and image: UIImage? = nil) {
        titleLabel.text = translate(page.title)
        subTitleLabel.text = translate(page.subtitle)
        guard let theImage = image else { imageView.image = UIImage(named: page.imageName); return }
        imageView.image = theImage
    }
}
