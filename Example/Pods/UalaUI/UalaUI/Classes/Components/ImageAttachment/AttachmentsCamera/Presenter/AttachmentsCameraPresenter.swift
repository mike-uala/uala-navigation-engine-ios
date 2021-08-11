import UIKit
import UalaCore

public class AttachmentsCameraPresenter: AttachmentsCameraPresenterProtocol {

    weak var view: AttachmentsCameraViewProtocol?
    var interactor: AttachmentsCameraInteractorProtocol?
    var router: AttachmentsCameraRouterProtocol?
    var cameraDelegate: AttachmentCameraDelegate?
    var cameraController: CameraController
    
    var pictureTaken:UIImage?
    var attachmentType: AttachmentType
    var allowsEditing: Bool = true
    var picturePickerDelegate:PicturePickerHelper
    
    public var cameraPermissionsHelper: CameraPermissionsHelperProtocol = CameraPermissionsHelper()
    
    init(attachmentType: AttachmentType) {
        self.cameraController = CameraController()
        self.picturePickerDelegate = PicturePickerHelper()
        self.attachmentType = attachmentType
        self.picturePickerDelegate.delegate = self
        self.cameraPermissionsHelper.delegate = self
    }
    
    func configureCameraController(cameraDisplay:UIView) {
        
        var defaultCamera: CameraController.CameraPosition = .front
        
        if [.document, .identification].contains(self.attachmentType)  {
            defaultCamera = .rear
        }
        
        cameraController.prepare(defaultCamera: defaultCamera, completion: {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(on: cameraDisplay)
        })
    }
    
    func switchCamera(){
        do {
            try cameraController.switchCameras()
        }
            
        catch {
            print(error)
        }
    }
    
    func capture(completionHandler: @escaping ()->Void){
        self.cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                completionHandler()
                return
            }
            
            self.pictureTaken = image
            self.router?.goToConfirm(picture: image, title: self.getAttachmentReviewTitleStrings(), description: self.getAttachmentReviewDescriptionStrings(), delegate: self)
            completionHandler()
        }
    }
    
    func openImagePicker(){
        self.router?.openImagePicker(delegate: self.picturePickerDelegate)
    }
    
    
    func closeView(){
        self.router?.closeView()
    }
    
    func getAttachmentReviewTitleStrings()->String{
        switch self.attachmentType {
        case .selfie:
            return translate("SELFIE_REVIEW_TITLE", from: .Common)
        case .document:
            return translate("DOCUMENT_REVIEW_TITLE", from: .Common)
        case .identification:
            return translate("IDENTIFICATION_REVIEW_TITLE", from: .Common)
        }
    }
    
    func getAttachmentReviewDescriptionStrings()->String{
        switch self.attachmentType {
        case .selfie:
            return translate("SELFIE_REVIEW_DESCRIPTION", from: .Common)
        case .document:
            return translate("DOCUMENT_REVIEW_DESCRIPTION", from: .Common)
        case .identification:
            return translate("IDENTIFICATION_REVIEW_DESCRIPTION", from: .Common)
        }
    }
    
    func checkCameraPermission() {
        cameraPermissionsHelper.checkCameraVideoPermission()
    }
}

extension AttachmentsCameraPresenter: AttachmentsReviewDelegate {
    
    func reviewConfirm() {
        if let picture = self.pictureTaken{
            self.cameraDelegate?.cameraPictureResult(picture: picture)
            self.router?.closeView()
        }
    }
    
    func didTapRetakePicture() {
        cameraDelegate?.didTapRetakePicture()
    }
}

extension AttachmentsCameraPresenter: PicturePickerDelegate {
    
    public func picturePicker(didFinishPickcing image: UIImage, type: UIImagePickerController.SourceType) {
        self.pictureTaken = image
        if allowsEditing {
            self.router?.goToConfirm(picture: image, title: self.getAttachmentReviewTitleStrings(), description: self.getAttachmentReviewDescriptionStrings(), delegate: self)
        } else {
            self.reviewConfirm()
            self.router?.closeView()
        }
    }
}

extension AttachmentsCameraPresenter: CameraPermissionsProtocol {
    
    public func cameraPermissionGranted() {
        view?.didCheckCameraPermission()
    }
    
    public func cameraPermissionDenied() {
        view?.showAlertCameraPermissionDenied()
    }
}
