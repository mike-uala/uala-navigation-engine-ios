//
//  PaymentAlertViewController.swift
//  Uala
//
//  Created by Nicolas on 23/01/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import UIKit
import UalaCore

public class PaymentAlertViewController: BaseViewController {
    
    public var paymentPresenter: PaymentAlertPresenter!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var crossButton: UIButton!
    
    public func configure(with model: AlertModel) {
        paymentPresenter.viewModel = model
    }
    
    public override var presenter: Presenter! {
        return paymentPresenter
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    private func customizeUI() {
        containerView.cornerRadius(radius: 14)
        
        imageBackgroundView.backgroundColor = UIColor.clear
        imageView.image = nil
        
        backButton.customize(style: .normal)
        backButton.addBorder(0.5, color: UalaStyle.colors.grey30)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.isHidden = true
        
        crossButton.isHidden = true
        crossButton.addTarget(self, action: #selector(onCross), for: .touchUpInside)

        titleLabel.customize(style: .title)
        titleLabel.text = nil
        subtitleLabel.customize(style: .subtitleWithOpacity)
        subtitleLabel.text = nil
    }
    
    @objc func backButtonPressed() {
        paymentPresenter.onButtonPressed()
    }
    
    @objc func onCross() {
        paymentPresenter.onCross()
    }
}

extension PaymentAlertViewController: PaymentAlertView {
    public func dismissAlertWith(animated flag: Bool, completion: @escaping () -> Void) {
        self.dismiss(animated: true, completion: completion)
    }
    
    public func updateButtonTitle(with text: String?) {
        guard let text = text else { return }
        backButton.isHidden = false
        backButton.setTitle(translate(text), for: .normal)
    }
    
    public func updateImage(named: String?) {
        guard let imageName = named else { return }
        imageView.image = CommonImage(named: imageName)
    }
    
    public func updateTitle(with text: String?) {
        guard let title = text else { return }
        titleLabel.text = translate(title)
    }
    
    public func updateSubtitle(with text: String?) {
        guard let subtitle = text else {
            subtitleLabel.isHidden = true
            return
        }
        subtitleLabel.text = subtitle
    }
    
    public func updateImageBackgroundColor(with color: UIColor?) {
        guard let color = color else { return }
        imageBackgroundView.backgroundColor = color
    }
    
    @objc public func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    
    public func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        self.view.addGestureRecognizer(tap)
    }
    
    public func updateCrossButton(isHidden: Bool?) {
        crossButton.isHidden = isHidden ?? false
    }
    
    public func updateCrossButton(with color: UIColor?) {
        guard let color = color else { return }
        crossButton.setTitleColor(color, for: .normal)
    }
}
