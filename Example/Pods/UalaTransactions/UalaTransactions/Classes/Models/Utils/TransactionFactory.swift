import Foundation
import UalaCore

class TransactionFactory {
    
    static var metadata: BancarMetadata!
    static var transaction: Transaction!
    static var createDate: Date?
    static var receipt: Bool?
    
    static func createTransaction (_ transaction: Transaction,
                                   _ metadata: BancarMetadata,
                                   _ createDate: Date?,
                                   _ receipt: Bool?) -> Transaction? {
        
        self.receipt = receipt
        self.metadata = metadata
        self.createDate = createDate
        self.transaction = transaction
        
        guard let factoryMethod = transaction.type.factoryMethod else { return transaction }
        return factoryMethod()
    }
    
    static func createTransfer() -> Transaction? {
        let transference = metadata.transference()
        if transference.sender?.username == UserSessionData.account?.username { return TransferSent(transaction, transference.recipient) }
        if transaction.status == .authorized { return TransferReceived(transaction, transference.sender) }
        
        return nil
    }
    
    static func createTransferReceived() -> Transaction? {
        let transference = metadata.transference()
        if transaction.status == .authorized { return TransferReceived(transaction, transference.sender) }
        
        return nil
    }
    
    static func createLoan() -> Transaction? {
        transaction.amount?.makeNegative()
        return transaction
    }
    
    static func createCashInOutCVU() -> Transaction? {
        let metadataCashInOutCVU = metadata.cashInOutCVU()
        var desc: String?
        if transaction.type == .cashInCVU {
            desc = metadata.dict["data.counterparty.name"]
        } else {
            desc = metadata.dict["destinationName"]
        }
        transaction.description = desc?.capitalized
        return CashInOutCVUTransaction(transaction, metadataCashInOutCVU.originAddress, metadataCashInOutCVU.destination, metadataCashInOutCVU.comment, metadataCashInOutCVU.claimNumber, operationId: metadataCashInOutCVU.operationId)
    }
    
    static func createInvestment() -> Transaction? {
        let metadataInvestment = metadata.investment()
        return InvestmentTransaction(transaction, metadataInvestment.rescueType)
    }
    
    static func createTDCCashIn() -> Transaction? {
        transaction.description = metadata.dict["entity"] ?? ""
        return transaction
    }
    
    static func createChargeCashIn() -> Transaction? {
            transaction.description = metadata.dict["entity"] ?? ""
            let metadataCashInCharge = metadata.cashInCharge()
        return Charge(transaction, metadataCashInCharge.IVA, metadataCashInCharge.IIGG, metadataCashInCharge.IIBB, metadataCashInCharge.retentions, metadataCashInCharge.commissionTotal + metadataCashInCharge.commissionIva, metadataCashInCharge.totalGross, metadataCashInCharge.buyerEmail, metadataCashInCharge.lastFourDigits, cardHolderName: metadataCashInCharge.cardHolderName)
        }
    
    static func createATMWithDraw() -> Transaction? {
        
        if transaction.type == .withdrawAtmFee && transaction.amount?.getAmount() ?? 0 == 0 { return nil }
        transaction.amount?.makeNegative()
        transaction.description = metadata.placeName()
        transaction.amount?.setImpactBalance(transaction.status != .canceled)
        transaction.error = metadata.rejected()
        
        return transaction
    }
    
    static func createBankTransferCashOut() -> Transaction? {
        return BankTransferCashOut(transaction, metadata.dict["cbu"], metadata.dict["bank"])
    }
    
    static func createRecharge() -> Transaction? {
        return Recharge(transaction, metadata.recharge(), createDate)
    }
    
    static func createBillPayment() -> Transaction? {
        return BillPaymentTransaction(transaction, metadata.dict["PFTransactionId"], receipt)
    }
    
    static func createAdjustment() -> Transaction? {
        return Adjustment(transaction, metadata.adjustment(), transaction.type == .creditAdjustment)
    }
    
    static func createSpending() -> Transaction? {
        transaction.error = metadata.rejected()
        transaction.description = metadata.placeName()
        
        return ShopSpending(transaction, metadata.spendingTaxes(), metadata.iibbProvinceName())
    }
    
    static func createInstallmentPayment() -> Transaction? {
        transaction.amount?.makeNegative()
        return transaction
    }
    
    static func createCashOutTDC() -> Transaction? {
        transaction.amount?.setImpactBalance(transaction.status != .canceled)
        transaction.amount?.makeNegative()
        return transaction
    }
    
    static func createCashOutTDCAdjustment() -> Transaction? {
        transaction.amount?.setImpactBalance(transaction.status != .canceled)
        return transaction
    }
    
    static func createTransaction(_ transaction: Transaction, _ dto: CommonTransactionDTO, _ operation: OperationType) -> Transaction? {
        switch transaction.type {
        case .phoneRecharge:
            transaction.type = .recharge
            guard let recharge = transaction.recharge else { return transaction }
            return Recharge(transaction, recharge, transaction.transactionDate)
        case .spending:
            transaction.error = dto.rejectCode()
            return ShopSpending(transaction)
        case .userToUser:
            return TransferSent(transaction, dto.contactReceiver())
        case .userToUserReceived:
            return TransferReceived(transaction, dto.contactSender())
        case .processorAdjustment:
            return Adjustment(transaction, nil, true)
        case .reprint:
            return CardReprint(transaction)
        case .atmClientFeeAdjustment:
            return AtmClientFeeAdjustment(transaction)
        case .genericPromoADPA:
            return GenericPromoADPA(transaction)
        case .cashInSpei:
            return SPEITransaction(transaction, dto.externalProviderTransactionId)
        case .cashOutSpei:
            return SPEITransaction(transaction)
        default:
            return transaction
        }
    }
}

private extension CommonTransactionDTO {
    func contactReceiver() -> Contact? {
        guard let username = receiver, let alias = receiverName else { return nil }
        return Contact(username, alias)
    }
    
    func contactSender() -> Contact? {
        guard let username = sender, let alias = senderName else { return nil }
        return Contact(username, alias)
    }
    
    func rejectCode() -> RejectedCode? {
        guard let error = rejectedReason else { return nil }
        return TransactionError(rawValue: error)?.spending
    }
}
