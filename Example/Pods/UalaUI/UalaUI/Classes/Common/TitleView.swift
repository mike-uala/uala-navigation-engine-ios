//
//  TitleView.swift
//  Uala
//
//  Created by Josefina Perez on 11/10/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public class TitleView: BaseFieldView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    public init(title: String) {
        super.init(frame: .zero)
        setupUI(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String) {
        titleLabel.customize(style: .regularBlackTwoLeft(size: 17))
        titleLabel.text = title
    }
    
}
