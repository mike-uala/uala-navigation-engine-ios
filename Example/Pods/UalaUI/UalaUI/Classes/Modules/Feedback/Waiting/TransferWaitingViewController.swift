//
//  TransferWaitingViewController.swift
//  Uala
//
//  Created by Nicolas on 05/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

public class TransferWaitingViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var botButton: UIButton!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    public var transferPresenter: TransferWaitingPresenter?
    
    override public var presenter: Presenter {
        return transferPresenter!
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
        transferPresenter?.makeRequest()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation(with: nil)
    }
    
    public func startAnimation(with color: CGColor?) {
        if let animationColor = color {
            progressView.startAnimation(withColor: animationColor)
        } else {
            progressView.startAnimation()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progressView.stopAnimation()
        transferPresenter?.cancelRequest()
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func customizeUI() {
          backgroundImageView.image = CommonImage(named: "transitions")
          titleLabel.customize(style: .regularWhiteCenter(size: 20))
          subtitleLabel.customize(style: .regularWhiteCenter(size: 14))
          topButton.addTarget(self, action: #selector(topButtonPressed), for: .touchUpInside)
          botButton.addTarget(self, action: #selector(botButtonPressed), for: .touchUpInside)
    }
    
    @objc func topButtonPressed() {
        transferPresenter?.topButtonPressed()
    }
    
    @objc func botButtonPressed() {
        transferPresenter?.botButtonPressed()
    }
    
    func closeWaiting() {
        transferPresenter?.cancelRequest()
    }
}

extension TransferWaitingViewController: WaitingViewProtocol {
    public func update(title: String?) {
        titleLabel.text = title
    }
    
    public func update(subtitle: String?) {
        subtitleLabel.text = subtitle
    }
    
    public func updateTopButton(action: FeedbackViewAction?) {
        updateButton(button: topButton, action: action)
    }
    
    public func updateBotButton(action: FeedbackViewAction?) {
        updateButton(button: botButton, action: action)
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


class ClearTransferWaitingViewController: TransferWaitingViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    override public func customizeUI() {
        titleLabel.textColor = UIColor.black
        subtitleLabel.textColor = UIColor.darkGray
        backgroundImageView.isHidden = true
        self.view.backgroundColor = UIColor(hex: "ffffff")
        topButton.addTarget(self, action: #selector(topButtonPressed), for: .touchUpInside)
        botButton.addTarget(self, action: #selector(botButtonPressed), for: .touchUpInside)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        startAnimation(with: UIColor.blue.cgColor)
    }
}
