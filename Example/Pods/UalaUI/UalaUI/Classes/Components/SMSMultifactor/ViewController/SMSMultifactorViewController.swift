//
//  SMSMultifactorViewController.swift
//  UalaUI
//
//  Created by Ualá on 13/07/21.
//

import UIKit
import UalaCore

public final class SMSMultifactorViewController: BaseViewController, SMSMultiFactorViewProtocol {

    public var smsMultiFactorPresenter: SMSMultiFactorPresenterProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var cellphoneLabel: UILabel!
    @IBOutlet weak var codeTextfieldView: PinTextFieldView!
    @IBOutlet weak var codeErrorLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    
    public override var presenter: Presenter? {
        return smsMultiFactorPresenter
    }
    
    let waitingTime = 60
    var countdown = 60
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        codeTextfieldView.delegate = self
        customizeUI()
    }
    
    public override func customizeNavigation() {
        super.customizeNavigation()
        self.navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    public func setUserCellphone(phoneNumber: String) {
        cellphoneLabel.isHidden = false
        cellphoneLabel.text = phoneNumber
    }
    
    func customizeUI() {
        customizeLabels()
        customizeButtons()
    }
    
    private func customizeLabels(){
        titleLabel.customize(style: .regular(size: 23, color: UalaStyle.colors.grey90))
        titleLabel.text = translate("MFA_CODE_TITLE", from: .SignUp)
        noticeLabel.customize(style: .regular(size: 15, color: UalaStyle.colors.grey70))
        noticeLabel.text = translate("MFA_CODE_NOTICE", from: .SignUp)
        noticeLabel.customize(style: .regular(size: 17, color: UalaStyle.colors.grey90))
        
        codeErrorLabel.customize(style: .regular(size: 13, color: UalaStyle.colors.red70))
        codeErrorLabel.isHidden = true
    }
    
    private func customizeButtons() {
        resendButton.customize(style: UalaStyle.buttons.standardUnfilledLight)
        fireCountDownTimer()
    }
    
    func fireCountDownTimer() {
        resendButton.isEnabled = false
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer) in
            if let counter = self?.countdown {
                if counter > 0 {
                    let remainingSeconds = (self?.countdown ?? 0).getMinutesAndSeconds()
                    let str = "\(translate("MFA_CODE_BUTTON", from: .SignUp)) (\(remainingSeconds))"
                    self?.resendButton.setTitleWithOutAnimation(str, for: .disabled)
                    self?.countdown -= 1
                } else {
                    self?.countdown = self?.waitingTime ?? 0
                    timer.invalidate()
                    self?.resendButton.isEnabled = true
                    self?.resendButton.setTitle(translate("MFA_CODE_BUTTON", from: .SignUp), for: .normal)
                }
            }
        }
    }
    
    public func showLoading() {
        self.showLoadingView()
    }
    
    public func hideLoading() {
        self.hideLoadingView()
    }
    
    @IBAction func resendCode(_ sender: Any) {
        smsMultiFactorPresenter?.resend()
        fireCountDownTimer()
    }
    
    public func onSuccessResend() {
        Toast.customToast(message: "Se ha reenviado el código").show()
    }
    
    public func onErrorSend(error: Error) {
        codeErrorLabel.text = translate(error.localizedDescription)
        codeErrorLabel.isHidden = false
    }
    
    public func onErrorResend(error: Error) {
        codeErrorLabel.text = translate(error.localizedDescription)
        codeErrorLabel.isHidden = false
    }
    
    public func onErrorVerify(error: Error) {
        codeErrorLabel.text = translate(error.localizedDescription)
        codeErrorLabel.isHidden = false
    }
}

extension SMSMultifactorViewController: PinTextFieldViewDelegate {
    public func pinTextFieldViewDidChange(_ pinTextField:  PinTextFieldView) {
        if pinTextField.text.count == 4 {
            let input = SMSMultifactorVerifyInputModel(pin: pinTextField.text)
            smsMultiFactorPresenter?.verify(input: input)
        }
    }
}
