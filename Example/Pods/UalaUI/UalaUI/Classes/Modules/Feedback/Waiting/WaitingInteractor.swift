import Foundation
import PromiseKit

public class WaitingInteractor {
    weak public var presenter: WaitingPresenterProtocol?
    public var waitingRequest: WaitingRequestProtocol?
    
    public init() {}
}

extension WaitingInteractor: WaitingInteractorProtocol {
    
    public func makeRequest() {
        waitingRequest?.transferWaitingCancellableRequest().done{ feedbackModel in
            self.presenter?.handleFeedback(feedbackModel: feedbackModel)
            }.catch { error in
                self.presenter?.handleFeedbackError(error: error)
        }
    }
    
    public func cancelRequest(){
        waitingRequest?.cancelPromise!()
    }
}
