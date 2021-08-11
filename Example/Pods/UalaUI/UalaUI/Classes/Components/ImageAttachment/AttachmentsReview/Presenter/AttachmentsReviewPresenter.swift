import UIKit

protocol AttachmentsReviewDelegate: class{
    func reviewConfirm()
    func didTapRetakePicture()
}

class AttachmentsReviewPresenter: AttachmentsReviewPresenterProtocol {    

    weak var view: AttachmentsReviewViewProtocol?
    var interactor: AttachmentsReviewInteractorProtocol?
    var router: AttachmentsReviewRouterProtocol?
    var delegate: AttachmentsReviewDelegate?
    
    
    func reviewConfirm() {
        delegate?.reviewConfirm()
    }
    
    func didTapRetakePicture() {
        delegate?.didTapRetakePicture()
    }

}
