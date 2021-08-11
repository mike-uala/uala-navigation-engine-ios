//
//  MockMFARepository.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 28/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import PromiseKit
@testable import UalaCore

class MockMFARepository: MFARepository {
    
    let phoneVerificationCode = "1234"
    
    override func sendPhoneVerificationCode(pinId: String, pin: String) -> Promise<Any?> {
        
        return Promise<Any?> { seal in
            
            if pin == self.phoneVerificationCode {
                seal.fulfill(nil)
            } else {
                let error = NSError(domain:"", code: 0, userInfo:nil)
                seal.reject(error)
            }
        }
        
    }
}
