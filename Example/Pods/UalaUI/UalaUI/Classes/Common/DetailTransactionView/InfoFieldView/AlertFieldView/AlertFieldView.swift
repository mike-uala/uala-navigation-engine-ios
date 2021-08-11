//
//  AlertFieldView.swift
//  Uala
//
//  Created by Alejandro Zalazar on 26/07/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public class AlertFieldView: BaseFieldView {

    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var stackContainer: UIStackView!
    
    var message: String
    
    public init(message: String) {
        self.message = message
        super.init(frame: .zero)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        alertView.layer.cornerRadius = 20.0
        messageLabel.text = message
    }
}
