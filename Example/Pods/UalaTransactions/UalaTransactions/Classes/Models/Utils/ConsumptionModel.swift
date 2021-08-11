//  ConsumptionModel.swift
//  Uala
//
//  Created by Nicolas on 15/01/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import UalaUI

public class ConsumptionModel {
    public var productCode: String!
    public var areaCode: String?
    public var phoneNumber: String?
    public var amount: String!
    public var subscriberCode: String?
    public var docType: String?
    public var docNumber: String?
    public var pin: String!
    public var ticket: String!
    
    public init() {}
    
    var type: RechargeType! {
        if areaCode?.isNotNull() != nil {
            return .areaCode
        } else if phoneNumber?.isNotNull() != nil {
            return .phone
        } else if subscriberCode?.isNotNull() != nil {
            return .subscriber
        } else {
            return .doc
        }
    }
    
    public var user: String! {
        
        switch self.type {
        case .areaCode?:
            guard let areaCode = self.areaCode, let phoneNumber = self.phoneNumber else { return "" }
            return "\(areaCode) \(phoneNumber)"
        case .phone?:
            guard let phoneNumber = self.phoneNumber else { return "" }
            return phoneNumber
        case .subscriber?:
            guard let code = self.subscriberCode else { return "" }
            return code
        case .doc?:
            guard let docNumber = self.docNumber else { return "" }
            return "\(docNumber)"
        default: return ""
        }
    }
    
    public var title: String! {
        guard let text = self.user else { return "" }
//        var title: String!
//        switch self.type {
//        case .areaCode?, .phone?: title = "Teléfono "
//        case .subscriber?: title = "Cuenta nro. "
//        default: title = ""
//        }
        
        return text
    }
    
    func map(from dic: [String: String]) {
        self.productCode = dic["productCode"] ?? ""
        self.areaCode = dic["areaCode"]?.isNotNull()
        self.phoneNumber = dic["phoneNumber"]?.isNotNull()
        self.subscriberCode = dic["subscriberCode"]?.isNotNull()
        self.docType = dic["docType"]?.isNotNull()
        self.docNumber = dic["docNumber"]?.isNotNull()
    }
}

enum DocType: String {
    case dni = "1"
    case lc = "2"
    case le = "3"
    
    var text: String {
        switch self {
        case .dni: return "DNI"
        case .lc: return "LC"
        case .le: return "LE"
        }
    }
}

enum RechargeType: String {
    case areaCode
    case phone
    case subscriber
    case doc
}
