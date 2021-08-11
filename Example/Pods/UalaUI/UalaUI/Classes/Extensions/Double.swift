//
//  Double.swift
//  Uala
//
//  Created by Nicolas on 5/9/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

public extension Double {
    var millionFormatted: String {
        return String(format: self >= 1000000 ? "$%.1fM" : "$%.0f", self >= 1000000 ? self/1000000 : self)
    }
    
    var metricFormatted: String {
        return String(format: self >= 1000 ? "%.1fKm." : "%.0fm.", self >= 1000 ? self/1000 : self)
    }
    
    func round(_ places: Int = 2) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

