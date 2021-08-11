import UIKit
import UalaCore

public class AttachmentsCameraView: UIViewController, AttachmentsCameraViewProtocol {
    
    var presenter: AttachmentsCameraPresenterProtocol?
    let cameraController = CameraController()
    var cameraConfiguration: AttachmentCameraConfigurationProtocol?
    
    @IBOutlet weak var cameraTakePhotoButton: UIButton!
    @IBOutlet weak var placeHolderText: UILabel!
    @IBOutlet weak var cameraDisplay: UIView!
    @IBOutlet weak var documentPlaceHolderShape: PlaceHolderShapeCameraView!
    @IBOutlet weak var identificationPlaceholderShape: PlaceHolderShapeCameraView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var placeHolderBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var swiftchCameraButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.checkCameraPermission()
        setUpUI()
    }
    
    func setUpUI(){
        addCloseButton()
        galleryButton.setImage(CommonImage(named: "ic-gallery"), for: .normal)
        swiftchCameraButton.setImage(CommonImage(named: "ic-switchcamera"), for: .normal)
        cameraTakePhotoButton.setImage(CommonImage(named: "ic-captureButton"), for: .normal)
        
        if let camType = self.cameraConfiguration?.attachmentType {
            switch camType{
            case .selfie:
                setUpSelfie()
            case .document:
                setUpDocument()
            case .identification:
                setUpIdentification()
            }
        }
        
        applyUIConfiguration()
    }
    
    func setUpSelfie(){
        self.documentPlaceHolderShape.placeHolderType = .selfie
    }
    
    func setUpDocument(){
        self.placeHolderBottomConstraint.constant = self.placeHolderBottomConstraint.constant - self.placeHolderText.frame.height
        self.documentPlaceHolderShape.setNeedsLayout()
        self.documentPlaceHolderShape.placeHolderType = .document
    }
    
    func setUpIdentification(){
        self.placeHolderBottomConstraint.constant = self.placeHolderBottomConstraint.constant - self.placeHolderText.frame.height
        self.identificationPlaceholderShape.setNeedsLayout()
        self.identificationPlaceholderShape.placeHolderType = .identification
    }
    
    private func applyUIConfiguration(){
        self.placeHolderText.isHidden = cameraConfiguration?.labelText == nil
        self.placeHolderText.text = cameraConfiguration?.labelText
        self.placeHolderText.setShadow(opacity: 1.0, radius: 2.0, color: UIColor.black.cgColor)
        self.galleryButton.isHidden = cameraConfiguration?.hideGalleryButton ?? true
    }
    
    func addCloseButton(){
        let button = UIButton(type: .custom)
        button.setImage(CommonImage(named: "ic-close"), for: .normal)
        button.addTarget(self, action: #selector(closePage), for: UIControl.Event.touchUpInside)
        button.tintColor = #colorLiteral(red: 0.3621281683, green: 0.3621373773, blue: 0.3621324301, alpha: 1)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func closePage(){
        self.presenter?.closeView()
    }
    
    @IBAction func capturePhoto(_ sender: Any) {
        self.cameraTakePhotoButton.isEnabled = false
        self.presenter?.capture{
            self.cameraTakePhotoButton.isEnabled = true
        }
    }
    
    @IBAction func switchCamera(_ sender: Any) {
        self.presenter?.switchCamera()
    }
    
    @IBAction func openPhotoLibraryAction(_ sender: Any) {
        self.presenter?.openImagePicker()
    }
    
    func didCheckCameraPermission() {
        presenter?.configureCameraController(cameraDisplay: cameraDisplay)
    }
    
    func showAlertCameraPermissionDenied() {
        showAlert(
            title: translate("CAMERA_PERMISSION"),
            message: translate("CAMERA_PERMISSION_DENIED")
        )
    }
}
