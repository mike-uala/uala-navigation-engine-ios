//
//  SearchTitleCollectionViewCell.swift
//  Uala
//
//  Created by Nicolas on 23/04/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

class SearchTitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    private let selectedColor: UIColor = UalaStyle.colors.cornflower
    private let unSelectedColor: UIColor = UalaStyle.colors.grey60
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    private func customizeUI() {
        titleLabel.customize(style: .mediumWarmGreyTwoCenter(size: 13))
        self.indicatorView.backgroundColor = selectedColor

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        self.indicatorView.backgroundColor = UalaStyle.colors.grey10
    }
    
    func selected() {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.textColor = self.selectedColor
            self.indicatorView.backgroundColor = self.selectedColor

        }
    }
    
    func unselected() {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.textColor = self.unSelectedColor
            self.indicatorView.backgroundColor = UalaStyle.colors.grey10
        }
    }

}
