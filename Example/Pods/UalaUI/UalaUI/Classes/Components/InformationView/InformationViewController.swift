//
//  InformationViewController.swift
//  UalaUI
//
//  Created by Luis Perez on 10/06/21.
//

import UIKit
import Lottie

public class InformationViewController: BaseViewController {
    @IBOutlet public weak var imageView: UIImageView!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var subtitleLabel: UILabel!
    @IBOutlet public weak var primaryActionButton: UIButton!
    @IBOutlet public weak var secondaryActionButton: UIButton!
    @IBOutlet public weak var animationContentView: UIView!
    
    public var navigationBarTintColor: UIColor = UalaStyle.colors.blue50
    private var animationView: Lottie.AnimationView?
    private let informationViewPresenter: InformationViewPresenterType
    
    public init(presenter: InformationViewPresenterType) {
        self.informationViewPresenter = presenter
        super.init(nibName: "InformationViewController", bundle: Bundle(for: InformationViewController.self))
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        informationViewPresenter.viewWillAppear()
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        informationViewPresenter.viewDidAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        informationViewPresenter.viewWillDisappear()
    }
    
    private func customizeUI() {
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.customize(style: .header)
        titleLabel.text = nil
        
        subtitleLabel.customize(style: .smallSubHeader)
        subtitleLabel.text = nil
        subtitleLabel.adjustsFontSizeToFitWidth = true
        
        primaryActionButton.customize(style: UalaStyle.buttons.standardFilledLight)
        primaryActionButton.addTarget(self, action: #selector(primaryActionButtonPressed), for: .touchUpInside)
        
        secondaryActionButton.customize(style: UalaStyle.buttons.standardUnfilledLight)
        secondaryActionButton.addTarget(self, action: #selector(secundaryActionButtonPressed), for: .touchUpInside)
    }
    
    public override func customizeNavigation() {
        navigationController?.navigationBar.tintColor = navigationBarTintColor
    }
  
    private func configureAnimation(animation: Lottie.Animation, imageProvider: BundleImageProvider) {
        self.animationView?.removeFromSuperview()
        let animationView = Lottie.AnimationView(animation: animation, imageProvider: imageProvider)
        self.animationView = animationView
        self.animationView?.contentMode = .scaleAspectFit
        self.animationView?.loopMode = .loop
        self.animationView?.frame = animationContentView.bounds
        animationContentView.addSubview(animationView)
    }
    
    @objc private func primaryActionButtonPressed() {
        informationViewPresenter.primaryActionButtonPressed()
    }
    
    @objc private func secundaryActionButtonPressed() {
        informationViewPresenter.secundaryActionButtonPressed()
    }
    
    @objc private func barButtonPressed() {
        informationViewPresenter.barButtonPressed()
    }
    
    @objc private func subtitleTapPressed() {
        informationViewPresenter.subtitleTapPressed()
    }
}

extension InformationViewController: InformationViewType {
    public func configureHyperlink() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.subtitleTapPressed))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.subtitleLabel.addGestureRecognizer(tapGestureRecognizer)
        self.subtitleLabel.isUserInteractionEnabled = true
    }
    
    public func playAnimation() {
        self.animationView?.play()
    }
    
    public func updateAnimation(animationName: String?) {
        guard let animationName = animationName,
            let animation = LottieAnimationProvider.Animations(rawValue: animationName),
            let lottieAnimation = LottieAnimationProvider.animation(animation: animation),
            let imageProvider = LottieAnimationProvider.imageProvider(animation: animation) else {
                return
        }
        self.animationContentView.isHidden = false
        self.imageView.isHidden = true
        self.configureAnimation(animation: lottieAnimation, imageProvider: imageProvider)
    }
    
    public func updateFooterTitle(text: String?) {}
    
    public func updateFooterIconImage(with image: String?) {}
    
    public func updateNavigationTitle(text: String?) {
        title = text
    }
    
    public func updateImage(named: String) {
        self.animationContentView.isHidden = true
        self.imageView.isHidden = false
        self.imageView.image = UIImage(named: named)
    }
    
    public func updateTitle(with attributedString: NSAttributedString?) {
        titleLabel.attributedText = attributedString
    }
    
    public func updateSubtitle(with attributedString: NSAttributedString?) {
        subtitleLabel.attributedText = attributedString
    }
    
    public func updatePrimaryActionTitle(with text: String) {
        primaryActionButton.setTitle(text, for: .normal)
    }
    
    public func removePrimaryActionButton() {
        if let button = primaryActionButton {
            button.removeFromSuperview()
        }
    }
    
    public func updateSecundaryActionTitle(with text: String) {
        secondaryActionButton.setTitle(text, for: .normal)
    }
    
    public func removeSecundaryActionButton() {
        if let button = secondaryActionButton {
            button.removeFromSuperview()
        }
    }
    
    public func addBarButton(with imageName: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: imageName),
            style: .plain,
            target: self,
            action: #selector(barButtonPressed)
        )
    }
}
