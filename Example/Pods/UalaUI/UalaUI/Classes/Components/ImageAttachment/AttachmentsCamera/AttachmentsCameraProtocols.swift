import Foundation
import UIKit

protocol AttachmentsCameraRouterProtocol: class {
    func goToConfirm(picture:UIImage,title:String,description:String, delegate: AttachmentsReviewDelegate)
    func openImagePicker(delegate:PicturePickerHelper)
    func closeView()
}

protocol AttachmentsCameraPresenterProtocol: class {
    var cameraController: CameraController { get set }
    var picturePickerDelegate:PicturePickerHelper { get set }
    var cameraDelegate: AttachmentCameraDelegate? { get set }
    var pictureTaken: UIImage? { get set }
    var attachmentType: AttachmentType { get set }
    
    func checkCameraPermission()
    func configureCameraController(cameraDisplay: UIView)
    func switchCamera()
    func capture(completionHandler: @escaping ()->Void)
    func openImagePicker()
    func closeView()
}


protocol AttachmentsCameraInteractorProtocol: class {
    
    var presenter: AttachmentsCameraPresenterProtocol?  { get set }
}


protocol AttachmentsCameraViewProtocol: class {
    
    var presenter: AttachmentsCameraPresenterProtocol?  { get set }
    var cameraConfiguration: AttachmentCameraConfigurationProtocol? { get set }
    
    func didCheckCameraPermission()
    func showAlertCameraPermissionDenied()
}
