import PromiseKit

public protocol WaitingRequestProtocol {
    func transferWaitingCancellableRequest() -> Promise<FeedbackModel>
    var cancelPromise: (() -> ())? { get set }
}
