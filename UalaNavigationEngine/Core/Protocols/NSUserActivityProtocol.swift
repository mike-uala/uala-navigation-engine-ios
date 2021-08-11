//
//  NSUserActivityProtocol.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation

public protocol NSUserActivityProtocol {
    
    var activityType: String { get }
    var userInfo: [AnyHashable: Any]? { get }
}
