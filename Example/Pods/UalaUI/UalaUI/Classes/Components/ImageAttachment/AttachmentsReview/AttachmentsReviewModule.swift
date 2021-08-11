import UIKit

class AttachmentsReviewModule {

    static func build(image:UIImage,title:String,description:String,delegate:AttachmentsReviewDelegate) -> UIViewController {
        let view: AttachmentsReviewView = AttachmentsReviewView.loadXib()
        let interactor = AttachmentsReviewInteractor()
        let router = AttachmentsReviewRouter()
        let presenter = AttachmentsReviewPresenter()

        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        view.titleText = title
        view.descriptionText = description
        view.pic = image
        view.presenter?.delegate = delegate
        
        return view
    }    
}
