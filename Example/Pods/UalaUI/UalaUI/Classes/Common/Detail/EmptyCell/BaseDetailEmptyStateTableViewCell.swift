//
//  BaseDetailEmptyStateTableViewCell.swift
//  Uala
//
//  Created by Nicolas on 26/03/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

class BaseDetailEmptyStateTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }
    
    private func customizeUI() {
        titleLabel.customize(style: .regularSteelLeft(size: 20))
        titleLabel.textAlignment = .center
        
        subtitleLabel.customize(style: .regularSilverLeft(size: 14))
        subtitleLabel.textAlignment = .center
    }
    
    func configure(with model: BaseDetailEmptyStateModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }

}
