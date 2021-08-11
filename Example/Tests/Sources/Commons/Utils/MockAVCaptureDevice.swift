//
//  MockAVCaptureDevice.swift
//  UalaTests
//
//  Created by Josefina Perez on 26/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import AVKit

class MockAVCaptureDevice {
    
    static var authorizationStatus: AVAuthorizationStatus = .notDetermined
    
    class func authorizationStatus(for cameraMediaType: AVMediaType) -> AVAuthorizationStatus {
        return authorizationStatus
    }
    
    class func requestAccess(for mediaType: AVMediaType, completionHandler handler: @escaping (Bool) -> Void) {
       handler(true)
    }
}
