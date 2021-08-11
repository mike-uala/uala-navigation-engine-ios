//
//  UpdatePepRequest.swift
//  Uala
//
//  Created by Nelson Domínguez on 08/08/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public struct UpdatePepRequest {
    
    public let pep: Bool
    public let relationship: String?
    public let position: String?
    public let obligatedEntity: String?
    
    public init(pep: Bool, relationship: String?, position: String?, obligatedEntity: String?) {
        self.pep = pep
        self.relationship = relationship
        self.position = position
        self.obligatedEntity = obligatedEntity
    }
}

