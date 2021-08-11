import Foundation
import PromiseKit

public class TransferWaitingPresenter: Presenter {
    weak public var view: WaitingViewProtocol?
    public var router: WaitingRouterProtocol?
    public var interactor: WaitingInteractorProtocol?
    public var model: FeedbackWaitingModel?
    
    public func viewDidLoad() {
        guard let model = self.model else { return }
        
        self.view?.update(title: model.title)
        self.view?.update(subtitle: model.subtitle)
        self.view?.updateTopButton(action: model.topButtonAction)
        self.view?.updateBotButton(action: model.botButtonAction)
    }
    
    public init() {}
    
}

extension TransferWaitingPresenter: WaitingPresenterProtocol {
    
    public func customizeUI() {
        view?.customizeUI()
    }
    
    public func topButtonPressed() {
        guard let action = model?.topButtonAction else { return }
        action.buttonPressed(view: nil)
    }
    
    public func botButtonPressed() {
        guard let action = model?.botButtonAction else { return }
        action.buttonPressed(view: view)
    }
    
    public func handleFeedback(feedbackModel: FeedbackModel) {
            router?.navigateToSuccess(model: feedbackModel)
    }
    
    public func handleFeedbackError(error: Error) {
        router?.navigateToFailure()
    }
    
    public func makeRequest() {
        interactor?.makeRequest()
    }
    
    func cancelRequest() {
        interactor?.cancelRequest()
    }
}
