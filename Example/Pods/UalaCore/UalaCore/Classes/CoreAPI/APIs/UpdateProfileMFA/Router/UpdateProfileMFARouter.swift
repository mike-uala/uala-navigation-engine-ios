//
//  UpdateProfileMFARouter.swift
//  UalaCore
//
//  Created by Ualá on 22/06/21.
//

import Alamofire

struct UpdateProfileMFARouter: UpdateProfileMFARoutable {
    
    var route: UpdateProfileMFARoute = .send
    
    var path: String {
        switch route {
        case .send:
            return "/1/mfa/send"
        case .resend:
            return "/1/mfa/resend"
        }
    }
    
    var mapper: Mappeable {
        switch route {
        case .send:
            return UpdateProfileMFAMap()
        case .resend:
            return UpdateProfileMFAMap()
        }
    }
    
    var parameters: Parameters? {
        switch route {
        case .resend(let pinId):
            return ["pinId" : pinId]
        default:
            return nil
        }
    }
    
    var baseUrl: String {
        switch scheme() {
        case .stage:
            return "https://services-mfa.api.stage.debit.mx.ua.la"
        case .test:
            return "https://services-mfa.api.test.debit.mx.ua.la"
        case .develop:
            return "https://services-mfa.api.dev.debit.mx.ua.la"
        case .production:
            return "https://services-mfa.api.prod.debit.mx.ua.la"
        }
    }
}
