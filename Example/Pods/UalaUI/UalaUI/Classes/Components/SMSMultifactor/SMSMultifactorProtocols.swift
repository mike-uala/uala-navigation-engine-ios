//
//  SMSMultifactorProtocols.swift
//  UalaUI
//
//  Created by Ualá on 13/07/21.
//

import Foundation
import UalaCore

public protocol SMSMultiFactorPresenterProtocol: AnyObject, Presenter {
    
    var viewController: SMSMultiFactorViewProtocol? { get set }
    var interactor: SMSMultiFactorInteractorProtocol? { get set }
    var router: SMSMultiFactorRouterProtocol? { get set }
    
    var sendInput: SMSMultifactorSendInputModel? { get set }
    var resendInput: SMSMultifactorResendInputModel? { get set }
    var verifyInput: SMSMultifactorVerifyInputModel? { get set }
    
    /// Send
    func send() /// Called from viewDidLoad
    func onSuccessSend() /// Called from interactor
    func onErrorSend(error: Error) /// Called from interactor
    /// Resend
    func resend() /// Called from view when resend button is touched
    func onSuccessResend() /// Called from interactor
    func onErrorResend(error: Error) /// Called from interactor
    /// Verify
    func verify(input: SMSMultifactorVerifyInputModel) /// Called from view when the code is entered
    func onSuccessVerify() /// Called from interactor
    func onErrorVerify(error: Error) /// Called from interactor
}

public extension SMSMultiFactorPresenterProtocol {
    
    func viewDidLoad() {
        send()
    }
    
    /// Send
    func send() {
        viewController?.showLoading()
        interactor?.send(input: sendInput)
    }
    func onSuccessSend() {
        viewController?.hideLoading()
        viewController?.onSuccessSend()
    }
    func onErrorSend(error: Error) {
        viewController?.hideLoading()
        viewController?.onErrorSend(error: error)
    }
    /// Resend
    func resend() {
        guard let resendInput = self.resendInput else { return }
        viewController?.showLoading()
        interactor?.resend(input: resendInput)
    }
    func onSuccessResend() {
        viewController?.hideLoading()
        viewController?.onSuccessResend()
    }
    func onErrorResend(error: Error) {
        viewController?.hideLoading()
        viewController?.onErrorResend(error: error)
    }
    /// Verify
    func verify(input: SMSMultifactorVerifyInputModel) {
        viewController?.showLoading()
        interactor?.verify(input: input)
    }
    func onSuccessVerify() {
        viewController?.hideLoading()
        router?.showSuccessfulView()
    }
    func onErrorVerify(error: Error) {
        viewController?.hideLoading()
        viewController?.onErrorVerify(error: error)
    }
}

public protocol SMSMultiFactorInteractorProtocol: AnyObject {
    var presenter: SMSMultiFactorPresenterProtocol? { get set }
    /// Send
    func send(input: SMSMultifactorSendInputModel?)
    /// Resend
    func resend(input: SMSMultifactorResendInputModel)
    /// Verify
    func verify(input: SMSMultifactorVerifyInputModel)
}

public protocol SMSMultiFactorRouterProtocol: AnyObject {
    var viewController: SMSMultiFactorViewProtocol? { get set }
    func showErrorView()
    func showSuccessfulView()
}

public protocol SMSMultiFactorViewProtocol: AnyObject {
    var smsMultiFactorPresenter: SMSMultiFactorPresenterProtocol? { get set }
    func showLoading()
    func hideLoading()
    /// Send
    func onSuccessSend()
    func onErrorSend(error: Error)
    /// Resend
    func onSuccessResend()
    func onErrorResend(error: Error)
    /// Verify
    func onSuccessVerify()
    func onErrorVerify(error: Error)
    func setUserCellphone(phoneNumber: String)
}

public extension SMSMultiFactorViewProtocol {

    func onSuccessVerify() {}

    func onSuccessResend() {}

    func onSuccessSend() {}
}
