//
//  TransactionTableViewCell.swift
//  Uala
//
//  Created by Germain Seijas on 25/7/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import UIKit
import UalaCore

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    @IBOutlet weak var amountCell: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imgInstallmentAllowed: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customizeUI()
    }
    
    var decorator: TransactionCellDecoratorProtocol! {
        didSet {
            guard decorator != nil else { return }
            fillInfo(with: decorator)
        }
    }
    
    func configureBackgroundColor(color: UIColor) {
        self.bgView.backgroundColor = color
        self.backgroundColor = color
    }
    
    func customizeUI() {
        self.selectionStyle = .none
        titleCell.font = UIFont.regular(size: 15)
        titleCell.textColor = UalaStyle.colors.grey70
        
        amountCell.font = UIFont.light(size: 15)
        titleCell.textColor = UalaStyle.colors.grey70
        
        dateCell.font = UIFont.regular(size: 13)
        dateCell.textColor = UalaStyle.colors.grey50
        
        dateLabel.font = UIFont.regular(size: 13)
        dateLabel.textColor = UalaStyle.colors.grey50
        
    }
    
    func fillInfo(with decorator: TransactionCellDecoratorProtocol) {
        titleCell.text = decorator.getTitle()
        dateCell.attributedText = decorator.getDescription()
        dateLabel.text = decorator.getDate()
        amountCell.attributedText = decorator.getAmount()
        imgCell.image = decorator.getIcon()
        imgInstallmentAllowed.isHidden = !decorator.showInstallmentAllowedImage()
    }
        
    override func prepareForReuse() {
        amountCell.isHidden = false
        dateLabel.isHidden = false
        dateCell.textColor = UalaStyle.colors.grey50
    }
    
}
