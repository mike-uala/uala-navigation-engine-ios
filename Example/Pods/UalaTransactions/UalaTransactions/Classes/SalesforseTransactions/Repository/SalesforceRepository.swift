//
//  SalesforceRepository.swift
//  UalaTransactions
//
//  Created by Enzo Digiano on 06/11/2020.
//

import Foundation
import Alamofire
import PromiseKit
import UalaCore

public protocol SalesforceRepositoryProtocol {
    func cashOutCVU(transactionId: String) -> Promise<Claim>
    func cashInCVU(name: String, dni: String, date: String, file: String, fileExtension: String, amount: String) -> Promise<Claim>
    func cashInCash(entity: String, date: String, file: String, fileExtension: String, amount: String) -> Promise<Claim>
    func genericCase(message: String) -> Promise<Claim>
    func getChatStatus() -> Promise<ChatStatus>
    func getChatStatusMX() -> Promise<ChatStatus>
    func getChatStatusARG() -> Promise<ChatStatus>
}

public class SalesforceRepository: BaseRepository, SalesforceRepositoryProtocol {
    
    private var exchangeApi = SalesforceExchangeAPI(SalesforceManager())

    public func cashOutCVU(transactionId: String) -> Promise<Claim> {
        return requestAuth(exchangeApi.exchangeSalesforceAPI(route: .cashOutCVU(transactionId: transactionId)))
    }

    public func cashInCVU(name: String, dni: String, date: String, file: String, fileExtension: String, amount: String) -> Promise<Claim> {
        return requestAuth(exchangeApi.exchangeSalesforceAPI(route: .cashInCVU(name: name,
                                                                               dni: dni,
                                                                               date: date,
                                                                               file: file,
                                                                               fileExtension: fileExtension,
                                                                               amount: amount)))
    }

    public func cashInCash(entity: String, date: String, file: String, fileExtension: String, amount: String) -> Promise<Claim> {
        return requestAuth(exchangeApi.exchangeSalesforceAPI(route: .cashInCash(entity: entity,
                                                                                date: date,
                                                                                file: file,
                                                                                fileExtension: fileExtension,
                                                                                amount: amount)))
    }
    
    public func genericCase(message: String) -> Promise<Claim> {
        return requestAuth(exchangeApi.exchangeSalesforceAPI(route: .genericCase(message: message)))
    }
    
    public func getChatStatus() -> Promise<ChatStatus> {
        return requestAuth(exchangeApi.exchangeSalesforceAPI(route: .getChatStatus))
    }

    public func getChatStatusMX() -> Promise<ChatStatus> {
        return requestAuth(exchangeApi.exchangeSalesforceAPI(route: .getChatStatusMX))
    }

    public func getChatStatusARG() -> Promise<ChatStatus> {
        return requestAuth(exchangeApi.exchangeSalesforceAPI(route: .getChatStatusARG))
    }
}
