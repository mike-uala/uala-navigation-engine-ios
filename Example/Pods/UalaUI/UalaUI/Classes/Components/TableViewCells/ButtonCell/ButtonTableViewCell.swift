//
//  ButtonTableViewCell.swift
//  Uala
//
//  Created by Nicolas on 20/05/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public protocol ButtonTableViewCellDelegate: class {
    func buttonPressed()
}

public class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainButton: UIButton!
    weak public var delegate: ButtonTableViewCellDelegate?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        customizeUI()
    }

    private func customizeUI() {
        self.selectionStyle = .none
        mainButton.customize(style: .normal)
        mainButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    public func configure(with title: String) {
        self.mainButton.setTitle(title, for: .normal)
    }
    
    @objc func buttonPressed() {
        delegate?.buttonPressed()
    }
}
