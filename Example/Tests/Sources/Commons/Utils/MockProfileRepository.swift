//
//  MockProfileRepository.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 26/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PromiseKit
@testable import UalaCore

class MockProfileRepository: ProfileRepository {
    
    override init() {
        print("init")
    }
    
    override func verify(securityCode: String) -> Promise<Bool> {
        return Promise<Bool> { seal in
            seal.fulfill(securityCode == "123456")
        }
    }
}
