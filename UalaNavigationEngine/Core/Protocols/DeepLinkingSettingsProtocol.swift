//
//  DeepLinkingSettingsProtocol.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation

public protocol DeepLinkingSettingsProtocol {
    
    var universalLinkSchemes: [String] { get }
    var universalLinkHosts: [String] { get }
    
    var internalDeepLinkSchemes: [String] { get }
    var internalDeepLinkHost: String { get }
}

