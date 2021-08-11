import Foundation

public protocol MFADelegate: class {
    func pinCodeSuccess(securityCode: String)
}

public protocol MFAViewProtocol: BaseView {
    func showKeyboard()
    func hideKeyboard()
    func showPinError(error: String)
    func showError(error: Error)
    func showLoading()
    func hideLoading()
}

public protocol MFAInteractorProtocol {
    func validate(securityCode: String)
    func makeRequest()
    var presenter: MFAPresenterProtocol? { get set }
    var reqProtocol: PinRequestProtocol? { get set }
}

public protocol MFAPresenterProtocol: Presenter {
    func securityCodeFilled(with value: String)
    func pushSecureKeyRecover()    
    func invalidCode(error: Error?)
    func handleSuccess() 
    func handleError(error: Error)
    
    var router: MFARouterProtocol? { get set }
}

public protocol MFARouterProtocol {
    var view: UIViewController? { get set }
    
    func showWaitingView()
    func pushSecureKeyRecover()
}
