import Foundation
import UalaCore

public protocol SecurityCodeDelegate: class {
    func pinCodeSuccess(securityCode: String)
}

open class MFAPresenter: MFAPresenterProtocol {
    
    public weak var view: MFAViewProtocol?
    public var interactor: MFAInteractorProtocol?
    public weak var delegate: SecurityCodeDelegate?
    public var router: MFARouterProtocol?
    public var eventTracker: EventTrackerProtocol?

    
    public init() {}
    
    open func viewDidAppear() {
        view?.showKeyboard()
    }
    
    open func securityCodeFilled(with value: String) {
        view?.showLoading()
        interactor?.validate(securityCode: value)
    }
    
    open func pushSecureKeyRecover() {
        eventTracker?.logEvent(name: "seguridad_selecciona_olvideclave", attributes: ["source": "nueva_transferencia"])
        router?.pushSecureKeyRecover()
    }
    
    open func handleSuccess() {
        self.view?.hideLoading()
        router?.showWaitingView()
    }
    
    open func handleError(error: Error) {
        self.view?.showError(error: error)
    }
    
    open func invalidCode(error: Error?) {
        self.view?.hideLoading()
        guard let ualaError = error as? UalaError else {
            self.view?.showPinError(error: error?.localizedDescription ?? "")
            return
        }
        self.view?.showPinError(error: ualaError.errorDescription ?? "")
    }
    
}
