//
//  MockCameraController.swift
//  UalaTests
//
//  Created by Josefina Perez on 26/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
@testable import UalaLoans

class CameraControllerSpy: CameraController {
    
    var previewWasDisplayed: Bool = false
     
    override func displayPreview(on view: UIView) throws {
        previewWasDisplayed = true
    }
}
