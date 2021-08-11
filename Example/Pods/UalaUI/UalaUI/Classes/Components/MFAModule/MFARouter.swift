import Foundation
import UIKit
import UalaCore

open class MFARouter {
    public var view: UIViewController?
    public var reqProtocol: PinRequestProtocol?
    public var waitingModel: FeedbackWaitingModel?
    
    public init() {}
}

extension MFARouter: MFARouterProtocol {
    @objc open func showWaitingView() { }
    public func pushSecureKeyRecover() {
        DeepLinking.triggerDeepLink(dlIntent: .goToRecoverPassword)
    }
}
