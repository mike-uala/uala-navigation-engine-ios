import Foundation
import UIKit

protocol AttachmentsReviewRouterProtocol: class {

}

protocol AttachmentsReviewPresenterProtocol: class {
    var delegate:AttachmentsReviewDelegate?{ get set }
    func reviewConfirm()
    func didTapRetakePicture()
}


protocol AttachmentsReviewInteractorProtocol: class {

  var presenter: AttachmentsReviewPresenterProtocol?  { get set }
}


protocol AttachmentsReviewViewProtocol: class {

    var presenter: AttachmentsReviewPresenterProtocol?  { get set }
    var titleText: String? { get set }
    var descriptionText: String? { get set }
    var pic: UIImage? { get set }
}
