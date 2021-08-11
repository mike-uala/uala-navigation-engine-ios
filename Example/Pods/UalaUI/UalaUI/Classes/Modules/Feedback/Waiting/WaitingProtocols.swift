import Foundation

public protocol WaitingViewProtocol: BaseView {
    func update(title: String?)
    func update(subtitle: String?)
    func customizeUI()
    func startAnimation(with color: CGColor?)
    func updateTopButton(action: FeedbackViewAction?)
    func updateBotButton(action: FeedbackViewAction?)
}

public protocol WaitingPresenterProtocol: AnyObject, Presenter {
    func handleFeedback(feedbackModel: FeedbackModel)
    func handleFeedbackError(error: Error)
    func makeRequest()
    func topButtonPressed()
    func botButtonPressed()
    func customizeUI()
    var router: WaitingRouterProtocol? { get set }
    var model: FeedbackWaitingModel? { get set }
}

public protocol WaitingInteractorProtocol {
    func makeRequest()
    func cancelRequest()
    var waitingRequest: WaitingRequestProtocol? { get set }
    var presenter: WaitingPresenterProtocol? { get set }
}

public protocol WaitingRouterProtocol {
    func navigateToSuccess(model: FeedbackModel)
    func navigateToFailure()
    var view: UIViewController? { get set }
}
