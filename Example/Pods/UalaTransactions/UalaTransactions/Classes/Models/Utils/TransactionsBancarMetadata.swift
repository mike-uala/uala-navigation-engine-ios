//
//  BancarMetadata.swift
//  Uala
//
//  Created by Hasael Oliveros on 7/26/17.
//  Copyright © 2017 Ualá. All rights reserved.
//

import Foundation
import UalaCore

extension BancarMetadata {
    func transference() -> Transaction.Transference {
        var transactionTo: Contact?
        var transactionFrom: Contact?
        if let usernameTo = self.dict["usernameTo"] {
            if let recipient = UserSessionData.contacts?.first(where: { $0.username == usernameTo }) {
                transactionTo = recipient
            } else {
                transactionTo = Contact(username: usernameTo)
            }
        }
        if let usernameFrom = self.dict["usernameFrom"] {
            if let sender = UserSessionData.contacts?.first(where: { $0.username == usernameFrom }) {
                transactionFrom = sender
            } else {
                transactionFrom = Contact(username: usernameFrom)
            }
        }
        
        return Transaction.Transference(sender: transactionFrom, recipient: transactionTo)
    }
    
    func placeName() -> String? {
        guard let placeName = self.dict["placeName"], !placeName.isNull else { return nil }
        return placeName
    }
    
    func recharge() -> Transaction.Recharge {
        let icon = self.dict["productIcon"]?.isNotNull() ?? ""
        let description = self.dict["productDescription"]?.isNotNull() ?? ""
        
        let recharge = ConsumptionModel()
        recharge.map(from: dict)
        var errorDesc = translate("PAYMENT_ERROR")
        
        if let dictCode = dict["tr_error_code"], let code = TransactionErrorCode(rawValue: dictCode) {
            errorDesc = code.description
        }
        
        if isInvalidSube() {
            errorDesc = TransactionErrorCode.invalidSube.description
        }
        
        return Transaction.Recharge(icon: icon, description: description, providerId: self.dict["providerTransactionId"], rechargeModel: recharge, errorCode: errorDesc)
    }
    
    private func isInvalidSube() -> Bool {
        guard self.dict["productCode"] == "003298" else { return false }
        let errorCode = self.dict["tr_error_desc"]
        let codes = errorCode?.components(separatedBy: ".").map({ $0.prefix(1) })
        let filter = codes?.filter({$0 == "1" || $0 == "4"})
        return !(filter?.isEmpty ?? true)
    }
    
    func adjustment() -> Transaction.Adjustment? {
        guard let code = dict["adjustmentConceptCode"] else { return nil }
        let conceptCode = AdjustmentCode(rawValue: code)
        let IVA = Double(self.dict["IVA"] ?? "")
        let baseAmount = Double(self.dict["baseAmount"] ?? "")
        return Transaction.Adjustment(conceptCode: conceptCode, IVA: IVA, baseAmount: baseAmount)
    }
    
    func spendingTaxes() ->  [String: Money] {
        var taxes: [String: Money] = [:]
        taxes[Taxes.IVA.rawValue] = Money(Double(self.dict["tax"] ?? "0"))
        taxes[Taxes.pais.rawValue] = Money(Double(self.dict["taxLaw27541"] ?? "0"))
        taxes[Taxes.IIBB.rawValue] = Money(Double(self.dict["taxIIBB"] ?? "0"))
        taxes[Taxes.RG4815.rawValue] = Money(Double(self.dict["taxRG4815"] ?? "0"))
        return taxes
    }
    
    func iibbProvinceName() -> String? {
        guard let provinceName = self.dict["taxIIBBProvince"], provinceName != "null" else {
            return nil
        }
        return provinceName
    }
    
    func rejected() -> RejectedCode? {
        guard let code = self.dict["rejectedCode"] else { return nil }
        return RejectedCode(rawValue: code)
    }
    
    func cashInOutCVU() -> Transaction.CashInOutCVU {
        let cbuFromMetadata = self.dict["data.counterparty.account_routing.address"] ?? ""
        let originAddress = cbuFromMetadata
        let destination = self.dict["destination"] ?? ""
        let comment = self.dict["comment"] ?? ""
        let claimNumber = self.dict["claimNumber"]
        let operationId = self.dict["bindServiceResponse.transaction_ids[1]"]
        return Transaction.CashInOutCVU(originAddress: originAddress, destination: destination, comment: comment, claimNumber: claimNumber, operationId: operationId)
    }
    
    func cashInCharge() -> Transaction.CashInCharge {
            let IVA = Double(self.dict["IVA"] ?? "") ?? 0.00
            let IIGG = Double(self.dict["IIGG"] ?? "") ?? 0.00
            let IIBB = Double(self.dict["IIBB"] ?? "") ?? 0.00
            let retentions = Double(self.dict["totalTax"] ?? "") ?? 0.00
            let commissionTotal = Double(self.dict["commissionAmountTotal"] ?? "") ?? 0.00
            let commissionIva = Double(self.dict["commissionIVA"] ?? "") ?? 0.00
            let totalGross = Double(self.dict["totalGross"] ?? "") ?? 0.00
            let buyerEmail = self.dict["buyerEmail"] ?? ""
            let lastFourDigits = self.dict["cardPan"] ?? ""
            let cardHolderName = self.dict["cardHolderName"] ?? ""
        return Transaction.CashInCharge(IVA: IVA, IIGG: IIGG, IIBB: IIBB, retentions: retentions, commissionTotal: commissionTotal , commissionIva: commissionIva, totalGross: totalGross, buyerEmail: buyerEmail, lastFourDigits: lastFourDigits, cardHolderName: cardHolderName)
        }
    
    func investment() -> Transaction.Investment {
        guard let rescueTypeMetadata = dict["TYPE_RESCUE"] else {
            return Transaction.Investment(rescueType: nil)
        }
        return Transaction.Investment(rescueType: rescueTypeMetadata)
    }
    
}
