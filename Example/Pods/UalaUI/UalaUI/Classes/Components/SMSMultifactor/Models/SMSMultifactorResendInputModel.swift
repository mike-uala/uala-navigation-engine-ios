//
//  SMSMultifactorResendInputModel.swift
//  UalaUI
//
//  Created by Matías Schwalb on 14/07/2021.
//

import Foundation

public struct SMSMultifactorResendInputModel {
    public var pinId: String?
    
    public init(pinId: String?) {
        self.pinId = pinId
    }
}
