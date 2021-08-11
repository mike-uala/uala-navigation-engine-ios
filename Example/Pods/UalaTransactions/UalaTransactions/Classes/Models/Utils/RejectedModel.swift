//
//  RejectedModel.swift
//  Uala
//
//  Created by Nicolas on 24/09/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import UalaUI
import UalaCore

public enum RejectedCode: String {
    case incorrectSecurity = "601"
    case incorrectSecurityCode = "602"
    case invalidPin = "632"
    case freezedCard = "329"
    case wrongExpirationDate = "901"
    case insuficientLimit = "310"
    case unsubscribedCard = "304"
    case accountBlocked = "322"
    case unknown
    
    init(safeRawValue: String) {
        let rawValue = safeRawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        self = RejectedCode(rawValue: rawValue) ?? .unknown
    }
}
