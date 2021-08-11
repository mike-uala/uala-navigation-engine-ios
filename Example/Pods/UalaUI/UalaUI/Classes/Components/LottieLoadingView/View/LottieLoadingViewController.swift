//
//  LottieLoadingViewController.swift
//  UalaUI
//
//  Created by Luis Perez on 19/03/21.
//

import UIKit
import Lottie

final public class LottieLoadingViewController: UIViewController {
    @IBOutlet public weak var lottieView: AnimationView!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var subtitleLabel: UILabel!
    
    private let viewModel: LottieLoadingViewViewModelType

    public init(viewModel: LottieLoadingViewViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: "LottieLoadingViewController", bundle: Bundle(for: LottieLoadingViewController.self))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        if self.viewModel.nsAttributedTitle != nil {
            self.titleLabel.attributedText = self.viewModel.nsAttributedTitle
        } else if self.viewModel.title != nil {
            self.titleLabel.text = self.viewModel.title
        }
        
        if self.viewModel.nsAttributedSubtitle != nil {
            self.subtitleLabel.attributedText = self.viewModel.nsAttributedSubtitle
        } else if self.viewModel.subtitle != nil {
            self.subtitleLabel.text = self.viewModel.subtitle
        }
        
        self.configureAnimationView(animation: self.viewModel.lottieAnimation)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.lottieView.play()
    }
    
    private func configureAnimationView(animation: LottieAnimationProvider.Animations) {
        guard let animation = LottieAnimationProvider.animation(animation: .spinningCircle),
              let imageProvider = LottieAnimationProvider.imageProvider(animation: .spinningCircle) else {
                return
        }

        lottieView.imageProvider = imageProvider
        lottieView.animation = animation
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit
    }
}
