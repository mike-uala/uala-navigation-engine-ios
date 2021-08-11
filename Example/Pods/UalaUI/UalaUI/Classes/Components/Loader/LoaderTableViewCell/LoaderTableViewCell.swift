//
//  LoaderTableViewCell.swift
//  Libraries
//
//  Created by Nicolas on 29/01/2019.
//  Copyright © 2019 Nicolas WANG. All rights reserved.
//

import UIKit

public class LoaderTableViewCell: UITableViewCell {

    @IBOutlet weak var gradientImage: LoaderGradientBar!
    @IBOutlet weak var gradientLabel: LoaderGradientBar!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }

    private func customizeUI() {
        self.selectionStyle = .none
    }
    
    public func startShimmering(isLoading: Bool) {
        gradientLabel.isLoading(isLoading)
        gradientImage.isLoading(isLoading)
    }
    
    func rounderImage() {
        gradientImage.cornerRadius(radius: gradientImage.width/2)
    }
}
