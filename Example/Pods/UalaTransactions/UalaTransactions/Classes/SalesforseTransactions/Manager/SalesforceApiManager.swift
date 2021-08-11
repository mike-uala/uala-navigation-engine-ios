//
//  SalesforceApiManager.swift
//  UalaTransactions
//
//  Created by Enzo Digiano on 06/11/2020.
//

import Foundation
import Alamofire
import PromiseKit
import UalaCore

public protocol SalesforceApiManager {
    var salesforceRoutable: SalesforceRouteable { get set }
}

public struct SalesforceManager: SalesforceApiManager {
    public init() { }
    public var salesforceRoutable: SalesforceRouteable = SalesforceRouter()
}

public struct SalesforceExchangeAPI {
    private var API: SalesforceApiManager
    
    public init(_ API: SalesforceApiManager) {
        self.API = API
    }
}

public extension SalesforceExchangeAPI {
    
    mutating func exchangeSalesforceAPI(route: SalesforceRoute) -> Routeable {
        API.salesforceRoutable.route = route
        return API.salesforceRoutable
    }
}
