//
//  URLGateway.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import UIKit
import PromiseKit

class URLGateway {
    
    static let domain = "com.justeat.URLGateway"
    
    enum ErrorCode: Int {
        case missingURLScheme
        case unsupportedUniversalLink
        case generic
    }

    private let universalLinkConverter: UniversalLinkConverter
    private let settings: DeepLinkingSettingsProtocol
    
    init(settings: DeepLinkingSettingsProtocol) {
        self.settings = settings
        self.universalLinkConverter = UniversalLinkConverter(settings: settings)
    }
    
    func handleURL(_ url: URL) -> Promise<DeepLink> {
        return Promise { seal in
            guard let scheme = url.scheme?.lowercased() else {
                let error = NSError(domain: URLGateway.domain, code: ErrorCode.missingURLScheme.rawValue, userInfo: nil)
                seal.reject(error)
                return
            }
            
            // 1. check if universal link
            if settings.universalLinkSchemes.contains(scheme), let result = self.resultForUniversalLink(url).result {
                seal.resolve(result)
            }
                
            // 2. check if deep link
            else if settings.internalDeepLinkSchemes.contains(scheme) {
                seal.fulfill(url)
            }
            
            // 3. generic error
            else {
                let genericError = NSError(domain: URLGateway.domain, code: ErrorCode.generic.rawValue, userInfo: nil)
                seal.reject(genericError)
            }
        }
    }
    
    private func resultForUniversalLink(_ url: UniversalLink) -> Promise<DeepLink> {
        return Promise { seal in
            if let deepLink = universalLinkConverter.deepLink(forUniversalLink: url) {
                seal.fulfill(deepLink)
            }
            else {
                let genericError = NSError(domain: URLGateway.domain, code: ErrorCode.unsupportedUniversalLink.rawValue, userInfo: nil)
                seal.reject(genericError)
            }
        }
    }
}

extension URL {
    
    func contains(subparts: [String]) -> Bool {
        return subparts.filter { absoluteString.contains($0) }.count > 0
    }
    
    var allQueryItems: [NSURLQueryItem] {
        let components = NSURLComponents(url: self as URL, resolvingAgainstBaseURL: false)!
        guard let allQueryItems = components.queryItems
            else { return [] }
        return allQueryItems as [NSURLQueryItem]
    }
    
    func queryItemValueFor(key: String) -> String? {
        let predicate = NSPredicate(format: "name=%@", key)
        let queryItem = (allQueryItems as NSArray).filtered(using: predicate).first as? NSURLQueryItem
        return queryItem?.value
    }
}

