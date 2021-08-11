//
//  UserRepository.swift
//  Uala
//
//  Created by Alejandro Zalazar on 31/05/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

public class UserRepository {
    let APIManager: BaseApiManager = ServiceLocator.inject()
    
    public init() {}
    
    public func editUser(parameters:Parameters) -> Promise<Any?> {
        return Promise<Any?> { seal in
            APIManager.requestApi2(path: "users", method: .put,parameters: parameters,encoding: JSONEncoding.default).done({ (json) in
                seal.fulfill(nil)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    public func validateCBU(id: String, value: String) -> Promise<Any?> {
        
        let parameters: Parameters = ["type" : id, "value" : value]
        
        return Promise<Any?> { seal in
            APIManager.requestApi2(path: "cbus", method: .post, parameters: parameters,encoding: JSONEncoding.default).done({ (json) in
                    seal.fulfill(nil)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    public func getCbus() -> Promise<[BankAccount]?> {
        return Promise<[BankAccount]?> { seal in
            APIManager.requestApi2(path: "cbus", method: .get, encoding: JSONEncoding.default).done({ (json) in
                if let jsonData = try? json["cbus"].rawData(){
                    let bankAccounts = try? JSONDecoder().decode([BankAccount].self, from: jsonData)
                    seal.fulfill(bankAccounts)
                }
                seal.fulfill(nil)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    public func updateCBU(_ cbu: String) -> Promise<Any?> {
        let parameters: Parameters = ["cbu" : cbu]
        return Promise<Any?> { seal in
            APIManager.requestApi2(path: "cbus", method: .put, parameters: parameters,encoding: JSONEncoding.default).done({ (json) in
                    seal.fulfill(nil)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }

    public func updateUserInfo(info: [String : Any]) -> Promise<User> {
        return Promise<User> { seal in
            let apiManager: BaseApiManager = ServiceLocator.inject()
            let parameters = info
            
            apiManager.requestApi2(path: "users", method: .put, parameters: parameters, encoding: JSONEncoding.default).done { json in
                let user = UserMapper.map(from: json["user"])
                seal.fulfill(user)
                }.catch { error in
                    seal.reject(error)
            }
        }
    }
}
