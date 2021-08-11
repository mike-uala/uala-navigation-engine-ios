import Foundation
import UIKit
import PromiseKit

public class WaitingModule {
    
    public static func build(waitingRequest: WaitingRequestProtocol? = nil, waitingRouter: WaitingRouterProtocol? = nil, model: FeedbackWaitingModel) -> BaseViewController {
        let view: TransferWaitingViewController = TransferWaitingViewController.loadXib()
        let presenter = TransferWaitingPresenter()
        let interactor = WaitingInteractor()
        
        var router: WaitingRouterProtocol = WaitingRouter()
        
        if let routerW = waitingRouter {
            router = routerW
        }
        
        view.transferPresenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.model = model
        
        interactor.presenter = presenter
        interactor.waitingRequest = waitingRequest
        
        router.view = view
        
        return view
    }
    
    public static func buildClear(waitingRequest: WaitingRequestProtocol? = nil, waitingRouter: WaitingRouterProtocol? = nil, model: FeedbackWaitingModel) -> BaseViewController {
        let view: ClearTransferWaitingViewController = TransferWaitingViewController.loadXib()
        let presenter = TransferWaitingPresenter()
        let interactor = WaitingInteractor()
        
        var router: WaitingRouterProtocol = ClearWaitingRouter()
        
        if let routerW = waitingRouter {
            router = routerW
        }
        
        view.transferPresenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.model = model
        
        interactor.presenter = presenter
        interactor.waitingRequest = waitingRequest
        
        router.view = view
        
        return view
    }
}
