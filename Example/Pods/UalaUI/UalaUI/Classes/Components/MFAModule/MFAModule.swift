import Foundation
import UIKit
import PromiseKit

public protocol EventTrackerProtocol {
    func logEvent(name: String, attributes: [String: Any])
}

public protocol PinRequestProtocol {
    var pinCode: String? { get set }
    func request() -> Promise<Void>?
}

public class MFAModule {
    
    static public func build(request: PinRequestProtocol,
                             waitingModel: FeedbackWaitingModel? = nil,
                             mfaRouter: MFARouter? = nil,
                             eventTracker: EventTrackerProtocol?) -> BaseViewController {
        let view: MFAView = MFAView.loadXib()
        let interactor = MFAInteractor()
        let presenter = MFAPresenter()
        let router = mfaRouter ?? MFARouter()
        
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.eventTracker = eventTracker
        
        interactor.presenter = presenter
        interactor.reqProtocol = request
        
        view.mfaPresenter = presenter
        
        router.view = view
        router.reqProtocol = request
        router.waitingModel = waitingModel
    
        return view
    }
}
