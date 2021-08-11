//
//  MockCameraPermissionHelper.swift
//  Uala
//
//  Created by Josefina Perez on 26/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import AVKit
@testable import UalaCore

class MockCameraPermissionsHelper: CameraPermissionsHelperProtocol {
    
    var delegate: CameraPermissionsProtocol?
    
    func checkCameraVideoPermission() {
        checkCameraPermission(for: .video)
    }
    
    func checkCameraPermission(for cameraMediaType: AVMediaType) {
        
        let cameraAuthorizationStatus = MockAVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .authorized:
            delegate?.cameraPermissionGranted()
        case .notDetermined:
            requestCameraAccess(forMediaType: cameraMediaType)
        default:
            delegate?.cameraPermissionDenied()
        }
    }
    
    func requestCameraAccess(forMediaType cameraMediaType: AVMediaType) {
        
        MockAVCaptureDevice.requestAccess(for: cameraMediaType, completionHandler: { granted in
            guard granted else {
                self.delegate?.cameraPermissionDenied()
                return
            }
            
            self.delegate?.cameraPermissionGranted()
        })
    }
}
