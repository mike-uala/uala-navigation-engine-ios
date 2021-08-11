//
//  DeepLinkingFacade.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation
import UIKit
import PromiseKit

public class DeepLinkingFacade {
        
    static let domain = "com.justeat.deepLinkingFacade"
    
    enum ErrorCode: Int {
        case couldNotHandleURL
        case couldNotHandleDeepLink
        case couldNotDeepLinkFromShortcutItem
        case couldNotDeepLinkFromSpotlightItem
    }
    
    private let flowControllerProvider: FlowControllerProvider
    private let navigationIntentHandler: NavigationIntentHandler
    private let urlGateway: URLGateway
    private let settings: DeepLinkingSettingsProtocol
    private let userStatusProvider: UserStatusProviding
    
    public init(flowControllerProvider: FlowControllerProvider,
                navigationTransitionerDataSource: NavigationTransitionerDataSource,
                settings: DeepLinkingSettingsProtocol,
                userStatusProvider: UserStatusProviding) {
        self.flowControllerProvider = flowControllerProvider
        self.navigationIntentHandler = NavigationIntentHandler(flowControllerProvider: flowControllerProvider,
                                                               userStatusProvider: userStatusProvider,
                                                               navigationTransitionerDataSource: navigationTransitionerDataSource)
        self.settings = settings
        self.userStatusProvider = userStatusProvider
        self.urlGateway = URLGateway(settings: settings)
    }
    
    @discardableResult
    public func handleURL(_ url: URL) -> Promise<Bool> {
        return Promise { seal in
            urlGateway.handleURL(url).done { deepLink in
                self.openDeepLink(deepLink)
            }.catch { error in
                let wrappedError = NSError(domain: DeepLinkingFacade.domain, code: ErrorCode.couldNotHandleURL.rawValue, userInfo: [NSUnderlyingErrorKey: error])
                seal.reject(wrappedError)
            }
        }
    }
    
    @discardableResult
    public func openDeepLink(_ deepLink: DeepLink) -> Promise<Bool> {
        let result = NavigationIntentFactory().intent(for: deepLink)
        switch result {
        case .result(let intent):
            return self.navigationIntentHandler.handleIntent(intent)
        case .error(let error):
            let wrappedError = NSError(domain: DeepLinkingFacade.domain, code: ErrorCode.couldNotHandleDeepLink.rawValue, userInfo: [NSUnderlyingErrorKey: error])
            return Promise { $0.reject(wrappedError) }
        }
    }
    
    @discardableResult
    public func openShortcutItem(_ item: UIApplicationShortcutItem) -> Promise<Bool> {
        let shortcutItemConverter = ShortcutItemConverter(settings: settings)
        if let deepLink = shortcutItemConverter.deepLink(forShortcutItem: item) {
            return openDeepLink(deepLink)
        }
        else {
            let error = NSError(domain: DeepLinkingFacade.domain, code: ErrorCode.couldNotDeepLinkFromShortcutItem.rawValue, userInfo: nil)
            return Promise { $0.reject(error) }
        }
    }
    
    @discardableResult
    public func openSpotlightItem(_ userActivity: NSUserActivityProtocol) -> Promise<Bool> {
        let spotlightItemConverter = SpotlightItemConverter(settings: settings)
        if let deepLink = spotlightItemConverter.deepLink(forSpotlightItem: userActivity) {
            return openDeepLink(deepLink)
        }
        else {
            let error = NSError(domain: DeepLinkingFacade.domain, code: ErrorCode.couldNotDeepLinkFromSpotlightItem.rawValue, userInfo: nil)
            return Promise { $0.reject(error) }
        }
    }
}

