//
//  MapLocationTableViewCell.swift
//  Alamofire
//
//  Created by Mobile Dev on 05/05/21.
//

import UIKit

class MapLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = UalaStyle.colors.grey30
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UalaStyle.colors.grey70
            titleLabel.font = .regular(size: 15.0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(location: MapLocationsModelProtocol) {
        titleLabel.text = location.title
    }
}
