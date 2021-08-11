//
//  CameraPermissionsProtocol.swift
//  Uala
//
//  Created by Josefina Perez on 25/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import AVFoundation

public protocol CameraPermissionsProtocol {
    func cameraPermissionGranted()
    func cameraPermissionDenied()
}

public protocol CameraPermissionsHelperProtocol {
    var delegate: CameraPermissionsProtocol? { get set}
    func checkCameraVideoPermission()
    func checkCameraPermission(for cameraMediaType: AVMediaType)
    func requestCameraAccess(forMediaType cameraMediaType: AVMediaType)
}

public class CameraPermissionsHelper: CameraPermissionsHelperProtocol {
    
    public var delegate: CameraPermissionsProtocol?
    
    public init() {}
    
    public func checkCameraVideoPermission() {
        checkCameraPermission(for: .video)
    }
    
    public func checkCameraPermission(for cameraMediaType: AVMediaType) {
        
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        
        switch cameraAuthorizationStatus {
        case .authorized:
             delegate?.cameraPermissionGranted()
        case .notDetermined:
            requestCameraAccess(forMediaType: cameraMediaType)
        default:
            delegate?.cameraPermissionDenied()
        }
    }
    
    public func requestCameraAccess(forMediaType cameraMediaType: AVMediaType) {
        AVCaptureDevice.requestAccess(for: cameraMediaType, completionHandler: { granted in
            DispatchQueue.main.async {
                if granted {
                    self.delegate?.cameraPermissionGranted()
                } else {
                    self.delegate?.cameraPermissionDenied()
                    return
                }
            }
        })
    }
    
}
