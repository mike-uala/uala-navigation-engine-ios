//
//  ShortcutItemConverter.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation
import UIKit

class ShortcutItemConverter {
    
    private lazy var deepLinkFactory: DeepLinkFactory = {
        return DeepLinkFactory(scheme: settings.internalDeepLinkSchemes.first!, host: settings.internalDeepLinkHost)
    }()
    
    private let settings: DeepLinkingSettingsProtocol
    
    init(settings: DeepLinkingSettingsProtocol) {
        self.settings = settings
    }
    
    func deepLink(forShortcutItem item: UIApplicationShortcutItem) -> DeepLink? {
        
        let components = item.type.components(separatedBy: "/")
        debugPrint("Components \(components)")
        return nil
    }
}

