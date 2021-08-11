//
//  ClearFeedbackViewController.swift
//  UalaUI
//
//  Created by Federico Andres Flores on 22/09/2020.
//

import UIKit

public class ClearFeedbackViewController: FeedbackViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
     func customizeUI() {
        self.navigationController?.navigationBar.isHidden = true
        titleLabel.customize(style: .regular(size: 20, color: UIColor.black, alignment: .center))
        subtitleLabel.customize(style: .regular(size: 14, color: UIColor.gray, alignment: .center))
        topButton.addTarget(self, action: #selector(topButtonPressed), for: .touchUpInside)
        botButton.addTarget(self, action: #selector(botButtonPressed), for: .touchUpInside)
    }
}
