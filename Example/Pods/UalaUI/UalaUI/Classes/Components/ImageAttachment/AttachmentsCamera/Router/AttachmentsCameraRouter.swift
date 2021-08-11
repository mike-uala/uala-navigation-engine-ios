import UIKit

class AttachmentsCameraRouter: AttachmentsCameraRouterProtocol {
    
    weak var viewController: UIViewController?
    var overlayView: UIView?
    var allowsEditing: Bool = true
    
    func goToConfirm(picture: UIImage, title: String, description: String,delegate:AttachmentsReviewDelegate) {
        let view = AttachmentsReviewModule.build(image: picture,title: title, description: description,delegate:delegate)
        self.viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func openImagePicker(delegate:PicturePickerHelper) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.view.backgroundColor = .white
        imagePickerController.view.contentMode = .center
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = delegate
        imagePickerController.allowsEditing = self.allowsEditing
        self.viewController?.present(imagePickerController, animated: true, completion: nil)
    }
    
    func closeView(){
        self.viewController?.dismiss(animated: true, completion: {})
    }
}
