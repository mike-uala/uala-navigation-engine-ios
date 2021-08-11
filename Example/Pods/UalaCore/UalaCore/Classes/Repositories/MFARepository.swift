//
//  MFARepository.swift
//  Uala
//
//  Created by Alejandro Zalazar on 30/05/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

public protocol MFARepositoryProtocol {
    func getPhoneVerificationCode(source: String) -> Promise<String?>
    func resendPhoneVerificationCode(pin:String,source:String) -> Promise<String?>
    func sendPhoneVerificationCode(pinId:String,pin: String) -> Promise<Any?>
}

// Multi-factor authentication (MFA)
public class MFARepository: MFARepositoryProtocol {
    let APIManager: BaseApiManager = ServiceLocator.inject()
    
    public init() { }
    
    public func getPhoneVerificationCode(source: String) -> Promise<String?> {
        return Promise<String?> { seal in
            APIManager.requestApi1(path: "user/verify?validationSource=\(source)", method: .get,encoding: JSONEncoding.default).done({ (json) in
                seal.fulfill(json["pinId"].string)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    public func resendPhoneVerificationCode(pin:String,source:String) -> Promise<String?> {
        return Promise<String?> { seal in
            APIManager.requestApi1(path: "user/verify/resend?validationSource=\(source)&pinId=\(pin)", method: .get,encoding: JSONEncoding.default).done({ (json) in
                seal.fulfill(json["pinId"].string)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    public func sendPhoneVerificationCode(pinId:String,pin: String) -> Promise<Any?> {
        return Promise<Any?> { seal in
            
            let parameters:Parameters = ["pinId" : pinId , "pin" : pin]
            
            APIManager.requestApi1(path: "user/verify", method: .post,parameters: parameters ,encoding: JSONEncoding.default).done({ (json) in
                seal.fulfill(nil)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
}
