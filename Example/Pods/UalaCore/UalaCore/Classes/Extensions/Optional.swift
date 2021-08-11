//
//  Optional.swift
//  Uala
//
//  Created by Nelson Domínguez on 29/07/2017.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == String {
    
    var isEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
    var safeString: String {
        guard let safeValue = self else { return "" }
        return safeValue
    }
}
