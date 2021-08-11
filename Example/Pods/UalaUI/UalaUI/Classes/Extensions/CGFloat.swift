//
//  CGFloat.swift
//  Uala
//
//  Created by Nicolas on 8/8/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
