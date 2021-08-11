//
//  FeedbackViewController.swift
//  Uala
//
//  Created by Nicolas on 05/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public class FeedbackViewController: BaseViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var botButton: UIButton!
    
    var feedbackPresenter: FeedbackPresenter?

    override public func viewDidLoad() {
        super.viewDidLoad()
        feedbackPresenter?.viewDidLoad()
        customizeUI()
    }
    
    private func customizeUI() {
        titleLabel.customize(style: .regularWhiteCenter(size: 20))
        subtitleLabel.customize(style: .regularWhiteCenter(size: 14))
        topButton.addTarget(self, action: #selector(topButtonPressed), for: .touchUpInside)
        botButton.addTarget(self, action: #selector(botButtonPressed), for: .touchUpInside)
    }
    
    @objc func topButtonPressed() {
        feedbackPresenter?.topButtonPressed()
    }
    
    @objc func botButtonPressed() {
        feedbackPresenter?.botButtonPressed()
    }

}

extension FeedbackViewController: FeedbackView {
    func update(backgroundImage: UIImage) {
        self.backgroundImageView.image = backgroundImage
    }
    
    func update(iconImage: UIImage) {
        self.iconImageView.image = iconImage
    }
    
    func update(title: String?) {
        self.titleLabel.text = title
    }
    
    func update(subtitle: String?) {
        self.subtitleLabel.text = subtitle
    }
    
    func updateTopButton(action: FeedbackViewAction?) {
        updateButton(button: self.topButton, action: action)
    }
    
    func updateBotButton(action: FeedbackViewAction?) {
        updateButton(button: self.botButton, action: action)
    }
    
    private func updateButton(button: UIButton, action: FeedbackViewAction?) {
        guard let action = action else {
            button.isHidden = true
            return
        }
        button.isHidden = false
        button.customize(style: action.style)
        button.setTitle(action.title, for: .normal)
    }
    
}
