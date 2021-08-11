//
//  SpotlightItemConverter.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation
import CoreSpotlight

class SpotlightItemConverter {
    
    private lazy var deepLinkFactory: DeepLinkFactory = {
        return DeepLinkFactory(scheme: settings.internalDeepLinkSchemes.first!, host: settings.internalDeepLinkHost)
    }()
    
    private let settings: DeepLinkingSettingsProtocol
    
    init(settings: DeepLinkingSettingsProtocol) {
        self.settings = settings
    }
    
    func deepLink(forSpotlightItem userActivity: NSUserActivityProtocol) -> DeepLink? {
        guard userActivity.activityType == CSSearchableItemActionType, let uniqueIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String else { return nil }
        
        let components = uniqueIdentifier.components(separatedBy: "/")

        debugPrint("Components \(components)")
        return nil
    }
}

