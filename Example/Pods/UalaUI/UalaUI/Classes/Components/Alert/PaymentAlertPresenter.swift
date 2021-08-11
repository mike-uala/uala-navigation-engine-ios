//
//  PaymentAlertPresenter.swift
//  Uala
//
//  Created by Nicolas on 23/01/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation


public protocol PaymentAlertView: BaseView {
    func updateImage(named: String?)
    func updateTitle(with text: String?)
    func updateSubtitle(with text: String?)
    func updateImageBackgroundColor(with color: UIColor?)
    func updateButtonTitle(with text: String?)
    func updateCrossButton(isHidden: Bool?)
    func dismissAlert()
    func dismissAlertWith(animated flag: Bool, completion: @escaping () -> Void)
    func addTapGesture()
    func updateCrossButton(with color: UIColor?)
}

open class PaymentAlertPresenter: Presenter {
    var viewModel: AlertModel!
    public weak var view: PaymentAlertView?
    
   public init(
        view: PaymentAlertView
        ) {
        self.view = view
    }
    
    public func viewWillAppear() {
        view?.updateTitle(with: viewModel.title)
        view?.updateSubtitle(with: viewModel.subtitle)
        view?.updateImage(named: viewModel.imageNamed)
        view?.updateImageBackgroundColor(with: viewModel.imageColor)
        view?.updateButtonTitle(with: viewModel.buttonAction?.actionTitle)
        view?.updateCrossButton(isHidden: viewModel.crossButtonIsHidden)
        view?.updateCrossButton(with: viewModel.crossButtonColor)
        if let autoDismiss = viewModel.autoDismiss, autoDismiss {
            self.view?.addTapGesture()
            self.autoDismiss()
        }
    }
    
    
    private func autoDismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.view?.dismissAlert()
        }
    }
    
    func onButtonPressed() {
        viewModel.buttonAction?.actionButtonPressed(view: view)
    }
    
    open func onCross() {
        self.view?.dismissAlert()
    }

}
