//
//  AccountRouter.swift
//  UalaCore
//
//  Created by Federico Frias on 10/05/2021.
//

import Alamofire

struct AccountRouter: AccountRouteable {
    
    var route: AccountRoute = .account
    
    var path: String {
        switch route {
        case .account, .updateAccount:
            return "/1/users"
        case .features:
            return "/1/accounts/availablefeatures"
        case .createPin:
            return "1/users/pin"
        case .updateUserEmail:
            return "1/user/email/mfa"
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .account:
            return AccountMapper()
        case .features:
            return AccountFeaturesMapper()
        case .updateAccount:
            return UpdateAccountMapper()
        case .createPin:
            return CreatePinMapper()
        case .updateUserEmail:
            return UpdateUserEmail()
        }
    }
    
    var method: HTTPMethod {
        switch route {
        case .updateAccount:
            return .put
        case .createPin:
            return .post
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch route {
        case .createPin:
            return [
               "Content-Type": "application/json",
               "Accept": "application/json"
            ]
        default:
            return nil
        }
    }
    
    var baseUrl: String {
      return String.getConfigurationValue(forKey: .baseUrlDebit)
    }
    
}

