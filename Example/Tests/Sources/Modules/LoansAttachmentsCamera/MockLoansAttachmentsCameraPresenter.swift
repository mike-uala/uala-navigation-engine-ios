//
//  MockLoansAttachmentsCameraPresenter.swift
//  UalaTests
//
//  Created by Josefina Perez on 26/09/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
@testable import UalaLoans


class MockLoansAttachmentsCameraPresenter: LoansAttachmentsCameraPresenter {
    
    override func configureCameraController(cameraDisplay: UIView) {
        try? self.cameraController.displayPreview(on: cameraDisplay)
    }
}
