//
//  UniversalLinkConverter.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation
import CoreLocation

class UniversalLinkConverter {
        
    private lazy var deepLinkFactory: DeepLinkFactory = {
        return DeepLinkFactory(scheme: settings.internalDeepLinkSchemes.first!, host: settings.internalDeepLinkHost)
    }()
    
    private let settings: DeepLinkingSettingsProtocol
    
    init(settings: DeepLinkingSettingsProtocol) {
        self.settings = settings
    }
    
    func deepLink(forUniversalLink url: UniversalLink) -> DeepLink? {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let pathComponents = components.url?.pathComponents,
            let scheme = components.scheme,
            let host = components.host,
            settings.universalLinkHosts.contains(host),
            settings.universalLinkSchemes.contains(scheme) else { return nil }
        
        let queryItems = components.queryItems
        debugPrint("queryItems: \(String(describing: queryItems))")
        switch pathComponents.count {
        case 1:
            return deepLinkFactory.homeURL()
        default:
            return deepLinkFactory.homeURL()
        }
    }
    
    fileprivate func queryContainsKey(_ items: [URLQueryItem]?, key: String) -> Bool {
        guard let queryItems = items else { return false }
        return queryItems.filter({ $0.name.caseInsensitiveCompare(key) == .orderedSame }).count > 0
    }
    
    fileprivate func queryValue(_ items: [URLQueryItem]?, key: String) -> String? {
        guard let queryItems = items else { return nil }
        return queryItems.filter({ $0.name.caseInsensitiveCompare(key) == .orderedSame }).first?.value
    }
    
    fileprivate func postcodeFromString(_ string: String) -> String {
        let areaComponents = string.components(separatedBy: "-")
        
        if areaComponents.count > 0 {
            return areaComponents.first!
        }
        
        return string
    }
}

