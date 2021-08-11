import UIKit
import UalaCore
import MessageUI

struct SecurityModel {
    var title: String?
    var subtitle: String?
    var footer: String?
}

public class MFAView: BaseViewController {

    @IBOutlet weak var forgotKeyLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pinCodeTextField: UalaPinCodeField!
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet weak var openRecoverSecureKeyBtn: UIButton!
    @IBOutlet weak var bottomStackConstraint: NSLayoutConstraint!
    
    public var mfaPresenter: MFAPresenter!
    public var ualaError: UalaError?
    
    private var shouldHideResetPinButton: Bool = false
    let enviromet = EnvironmentHelper().localeIdentifier
    
    override public func viewDidLoad() {
        customizeUI()
        super.viewDidLoad()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let error = ualaError {
            mfaPresenter.invalidCode(error: error)
        }
        pinCodeTextField.becomeFirstResponder()
    }
    
    func configure(delegate: SecurityCodeDelegate?, title: String?, model: SecurityModel?) {
        mfaPresenter.delegate = delegate
        guard let title = title else { return }
        self.title = title
    }
    
    private func customizeUI() {
        pinNormal()
        titleLabel.text = translate("MFA_TITLE", from: .Common)
        titleLabel.customize(style: .regularWarmGreyCenter(size: 20))
                
        incorrectLabel.customize(style: .regularError(size: 13))
        incorrectLabel.isHidden = true
        incorrectLabel.numberOfLines = 0
        
        pinCodeTextField.addTarget(self, action: #selector(pinCodeFieldChanged), for: .editingChanged)
        
        openRecoverSecureKeyBtn.customize(style: .normal)
        openRecoverSecureKeyBtn.addTarget(self, action: #selector(openSecureKeyRecover), for: .touchUpInside )
        bottomStackConstraint.setKeyboardShowObserver()
        
        forgotKeyLabel.text = translate("FORGOT_KEY_TEXT", from: .Common)
        forgotKeyLabel.customize(style: .mediumWarmGreyCenter(size: 16))
        
        emailButton.setTitle(translate("FORGOT_KEY_EMAIL", from: .Common), for: .normal)
        emailButton.customize(style: .normal)
        
        emailButton.isHidden = !shouldHideResetPinButton
        forgotKeyLabel.isHidden = !shouldHideResetPinButton
        openRecoverSecureKeyBtn.isHidden = shouldHideResetPinButton
    }
    
    override public func customizeNavigation() {
        navigationController?.setupTitle(color: .steel)
        navigationController?.navigationBar.tintColor = UalaStyle.colors.blue50
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    @objc func pinCodeFieldChanged() {
        if pinCodeTextField.isFilled {
            mfaPresenter.securityCodeFilled(with: pinCodeTextField.text)
        } else {
            pinNormal()
        }
    }
    
    @objc func openSecureKeyRecover() {
        mfaPresenter.pushSecureKeyRecover()
    }
    
    private func pinNormal() {
        pinCodeTextField.colorFilled = UalaStyle.colors.cornflower
        incorrectLabel.isHidden = true
        pinCodeTextField.color = .silver
    }
    
    public func shouldHideResetPin(_ shouldHide: Bool) {
        shouldHideResetPinButton = shouldHide
    }
    
    @IBAction func didPressEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([translate("FORGOT_KEY_EMAIL", from: .Common)])
            present(mail, animated: true)
        } else {
            showAlert(title: "No pudimos enviar el mail", message: "Puedes intentarlo desde tu aplicacion de mail")
        }
    }
}

extension MFAView: MFAViewProtocol {
    public func showError(error: Error) {
        self.hideLoading()
        self.showKeyboard()
        self.showAlert(with: error)
    }
    
    public func showLoading() {
        self.showLoadingView()
        self.hideKeyboard()
    }
    
    public func hideLoading() {
        self.hideLoadingView()
    }
    
    public func showPinError(error: String) {
        self.showKeyboard()
        incorrectLabel.text = error
        incorrectLabel.isHidden = false
        pinCodeTextField.text = ""
        pinCodeTextField.colorFilled = UalaStyle.colors.cornflower
    }

    public func showKeyboard() {
        pinCodeTextField.becomeFirstResponder()
    }
    
    public func hideKeyboard() {
        pinCodeTextField.resignFirstResponder()
    }
    
}

extension MFAView: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dissmiss()
    }
}
