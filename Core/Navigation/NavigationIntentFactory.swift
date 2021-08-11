//
//  NavigationIntentFactory.swift
//  UalaNavigationEngine
//
//  Created by Miguel Olmedo on 10/08/21.
//

import Foundation

public typealias ResetPasswordToken = String


public enum NavigationIntent: Equatable {
    case goToHome
    case goToLogin
    case goToResetPassword(ResetPasswordToken)
    case goToSettings
}

enum NavigationIntentFactoryResult {
    case result(NavigationIntent)
    case error(Error)
}

class NavigationIntentFactory {
    
    static let domain = "com.justeat.navigationIntentFactory"
    
    enum ErrorCode: Int {
        case malformedURL
        case unsupportedURL
    }
    
    func intent(for url: DeepLink) -> NavigationIntentFactoryResult {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let pathComponents = components.url?.pathComponents
            else {
                return .error(NSError(domain: NavigationIntentFactory.domain, code: ErrorCode.malformedURL.rawValue, userInfo: nil))
        }
        
        let queryItems = components.queryItems
        
        switch pathComponents.count {
        case 3:
            switch (pathComponents[1], pathComponents[2]) {
            case ("account", "login"):
                return .result(.goToLogin)
            default: break
            }
                
        case 2:
            switch pathComponents[1] {
            case "home":
                return .result(.goToHome)
            case "login":
                return .result(.goToLogin)
            case ("resetPassword") where queryContainsKey(queryItems, key: "resetToken"):
                return .result(.goToResetPassword(queryValue(queryItems, key: "resetToken")!))
            case ("settings"):
                return .result(.goToSettings)
            default: break
            }
            
        case 1:
            return .result(.goToHome)
            
        default: break
        }
        
        return .error(NSError(domain: NavigationIntentFactory.domain, code: ErrorCode.unsupportedURL.rawValue, userInfo: nil))
    }
    
    private func queryContainsKey(_ items: [URLQueryItem]?, key: String) -> Bool {
        guard let queryItems = items else { return false }
        return queryItems.filter({ $0.name.caseInsensitiveCompare(key) == .orderedSame }).count > 0
    }
    
    private func queryValue(_ items: [URLQueryItem]?, key: String) -> String? {
        guard let queryItems = items else { return nil }
        return queryItems.filter({ $0.name.caseInsensitiveCompare(key) == .orderedSame }).first?.value
    }
}
