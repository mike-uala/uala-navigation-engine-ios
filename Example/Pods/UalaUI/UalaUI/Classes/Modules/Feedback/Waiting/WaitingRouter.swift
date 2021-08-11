import Foundation
import UalaCore

public class WaitingRouter: WaitingRouterProtocol {
    
    public var view: UIViewController?
    
    public func navigateToSuccess(model: FeedbackModel) {
        let viewController = FeedbackModule.build(model: model)
        viewController.navigationBarHidden = true
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func navigateToFailure() {
        let viewController = FeedbackModule.build(model: .transferError(topButtonAction: nil))
        viewController.navigationBarHidden = true
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}

public class ClearWaitingRouter: WaitingRouterProtocol {
    
    public var view: UIViewController?
    
    public func navigateToSuccess(model: FeedbackModel) {
        let viewController = FeedbackModule.buildClear(model: model)
        viewController.navigationBarHidden = true
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func navigateToFailure() {
        let viewController = FeedbackModule.buildClear(model: .transferError(topButtonAction: nil))
        viewController.navigationBarHidden = true
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}


