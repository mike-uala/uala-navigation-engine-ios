//
//  LoansAttachmentsCameraTest.swift
//  UalaTests
//
//  Created by Josefina Perez on 26/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import XCTest
import AVKit
@testable import UalaLoans
@testable import UalaCore

class LoansAttachmentsCameraTest: XCTestCase {
    
    let view: LoansAttachmentsCameraView = LoansAttachmentsCameraView.loadXib()
    let interactor = LoansAttachmentsCameraInteractor()
    let presenter = MockLoansAttachmentsCameraPresenter(attachmentType: .selfie)
    let router = LoansAttachmentsCameraRouter()
    
    var cameraController = CameraControllerSpy()

    override func setUp() {
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        presenter.cameraController = cameraController
                
        let cameraPermissionsHelper = MockCameraPermissionsHelper()
        
        cameraPermissionsHelper.delegate = presenter
        presenter.cameraPermissionsHelper = cameraPermissionsHelper
    }
    
    func testLoadViewWithCameraPermissionAuthorized() {
        //arrange
        MockAVCaptureDevice.authorizationStatus = .authorized
    
        //act
        view.loadViewIfNeeded()
        
        //assert
        XCTAssertTrue(cameraController.previewWasDisplayed)
    }
    
    func testLoadViewWithCameraPermissionDenied() {
        //arrange
        MockAVCaptureDevice.authorizationStatus = .denied
        
        //act
        view.loadViewIfNeeded()
        
        //assert
        XCTAssertFalse(cameraController.previewWasDisplayed)
    }
}
