import UIKit

public class AttachmentsCameraModule {
    
    public static func build(configuration: AttachmentCameraConfigurationProtocol, delegate:AttachmentCameraDelegate, allowsEditing: Bool = true) -> UIViewController {
        let view: AttachmentsCameraView = AttachmentsCameraView.loadXib()
        let interactor = AttachmentsCameraInteractor()
        let router = AttachmentsCameraRouter()
        let presenter = AttachmentsCameraPresenter(attachmentType: configuration.attachmentType)
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.allowsEditing = allowsEditing
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.allowsEditing = allowsEditing
        router.viewController = view
        
        view.cameraConfiguration = configuration
        view.presenter?.cameraDelegate = delegate
        
        return view
    }
    
    public static func buildRoot(configuration: AttachmentCameraConfigurationProtocol, delegate: AttachmentCameraDelegate, allowsEditing: Bool = true) -> UINavigationController {
        let view = self.build(configuration: configuration,delegate: delegate, allowsEditing: allowsEditing)
        let navigation = UalaNavigationController(rootViewController: view)
        navigation.navigationBar.topItem?.title = configuration.titleLabel
        return navigation
    }
}
