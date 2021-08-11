//
//  TransactionEnums.swift
//  Uala
//
//  Created by Nicolas on 23/05/2018.
//  Copyright © 2018 Ualá. All rights reserved.
//

import Foundation
import SwiftyJSON
import UalaCore
import UalaUI

public enum RescueType: String {
    case normal = "FUND_RESCUE"
    case adjustment = "PERFORMANCE_ADJUSTMENT"
    case failedSuscription = "FAILED_SUBSCRIPTION"
}

public enum TransactionType: String {
    
    // MARK: - Multi-country TransactionTypes
    case refund = "REFUND"
    case cashInTDC = "CASH_IN_TDC"
    case billPayment = "BILL_PAYMENT"
    case userToUser = "USER_TO_USER"
    case userToUserReceived = "USER_TO_USER_RECEIVED"

    // MARK: - AR TransactionTypes
    case installmentLendingPayment = "INSTALLMENT_LENDING_PAYMENT"
    case cashInCvuReverse = "CASH_IN_CVU_REVERSE"
    case cashInCharge = "CASH_IN_SALES_ADQUIRENCIA"
    case payOffInstallment = "INSTALLMENT_LENDING_PAYOFF"
    case cashInInstallment = "CASH_IN_INSTALLMENT"
    case withdrawAtmFee = "WITHDRAW_ATM_FEE"
    case automaticDebit = "AUTOMATIC_DEBIT"
    case recharge = "TELERECARGAS_CARGA"
    case consumptionPOS = "CONSUMPTION_POS"
    case cashInDeposit = "CASH_IN_CBU_DEPOSIT"
    case cashInBankTransfer = "CASH_IN_BANK_TRANSFER"
    case loanInstallmentPayment = "LOAN_INSTALLMENT_PAYMENT"
    case cashOut = "CASH_OUT"
    case loanPayoff = "LOAN_PAYOFF"
    case cashInCVU = "CASH_IN_CVU"
    case cashOutCVU = "CASH_OUT_CVU"
    case cashInLoan = "CASH_IN_LOAN"
    case creditAdjustment = "CREDIT_ADJUSTMENT"
    case debitAdjustment = "DEBIT_ADJUSTMENT"
    case directDebitAdjustment = "DIRECT_DEBIT_CREDIT_ADJUSTMENT"
    case withdrawATM = "WITHDRAW_ATM"
    case investmentsSubscription = "INVESTMENTS_DEPOSIT"
    case investmentsWithdraw = "INVESTMENTS_WITHDRAW"
    case cashOutDeposit = "CASH_OUT_CBU_DEPOSIT"
    case adjustment = "ADJUSTMENT"
    case cashOutTDC = "CASH_OUT_TDC"
    case cashOutTDCAdjustment = "ADJUSTMENT_RAPIPAGO"
    case onlineCreditPayment = "ONLINE_CREDIT"
    case onlineCreditCashIn = "CASH_IN_ONLINE_CREDIT"
    case exchangeCashOut = "EXCHANGE_CASH_OUT"
    case exchangeCashIn = "EXCHANGE_CASH_IN"
    
    // MARK: - MX TransactionTypes
    case spending = "SPENDING"
    case phoneRecharge = "RECHARGE"
    case cashInSpei = "CASH_IN_SPEI"
    case cashOutSpei = "CASH_OUT_SPEI"
    case reprint = "REPRINT"
    case processorAdjustment = "PROCESSOR_ADJUSTMENT"
    case paynetClientFeeAdjustment = "PAYNET_CLIENT_FEE_ADJUSTMENT"
    case atmClientFeeAdjustment = "ATM_CLIENT_FEE_ADJUSTMENT"
    case genericPromoADPA = "GENERIC_PROMO_ADPA"
    case ualaAdjustment = "UALA_ADJUSTMENT"
    
    case unknown
    
    var factoryMethod: (() -> (Transaction?))? {
        switch self {
        case .recharge: return TransactionFactory.createRecharge
        case .cashInCharge: return TransactionFactory.createChargeCashIn
        case .userToUser: return TransactionFactory.createTransfer
        case .userToUserReceived : return TransactionFactory.createTransferReceived
        case .cashInTDC: return TransactionFactory.createTDCCashIn
        case .billPayment, .onlineCreditPayment: return TransactionFactory.createBillPayment
        case .loanInstallmentPayment, .loanPayoff: return TransactionFactory.createLoan
        case .cashOut: return TransactionFactory.createBankTransferCashOut
        case .consumptionPOS, .automaticDebit, .refund: return TransactionFactory.createSpending
        case .withdrawATM, .withdrawAtmFee: return TransactionFactory.createATMWithDraw
        case .creditAdjustment, .debitAdjustment: return TransactionFactory.createAdjustment
        case .cashInCVU, .cashOutCVU, .cashInCvuReverse: return TransactionFactory.createCashInOutCVU
        case .investmentsSubscription, .investmentsWithdraw: return TransactionFactory.createInvestment
        case .installmentLendingPayment, .payOffInstallment: return
        TransactionFactory.createInstallmentPayment
        case .cashOutTDC: return TransactionFactory.createCashOutTDC
        case .cashOutTDCAdjustment: return TransactionFactory.createCashOutTDCAdjustment
        default: return nil
       }
    }
}

public enum OperationType: String {
    case debit = "DEBIT"
    case credit = "CREDIT"
    
    var adjustment: TransactionType {
        switch self {
        case .debit:
            return .debitAdjustment
        case .credit:
            return .creditAdjustment
        }
    }
}

public enum TransactionCategory: String, CaseIterable {
    case purchases = "Compras"
    case entreteinment = "Entretenimiento"
    case restaurants = "Restaurantes y bares"
    case healthAndSports = "Salud y deportes"
    case services = "Servicios y débitos automáticos"
    case withoutCategory = "Sin categoría"
    case groceries = "Supermercados y alimentos"
    case transportation = "Transporte y auto"
    case travels = "Viajes y vacaciones"
    
    public var name: String {
        switch self {
        case .withoutCategory: return "Sin categoría"
        case .entreteinment: return "Entretenimiento"
        case .purchases: return "Compras"
        case .healthAndSports: return "Salud y deporte"
        case .groceries: return "Supermercados"
        case .restaurants: return "Restaurantes y bares"
        case .services: return "Servicios"
        case .transportation: return "Transporte"
        case .travels: return "Vacaciones"
        }
    }
    
    public var whiteImage: UIImage {
        return TransactionsImage(named: self.whiteImageName)!
    }
    
    public var whiteImageName: String {
        switch self {
        case .groceries: return "groceries_big_white"
        case .healthAndSports: return "sports_big_white"
        case .purchases: return "purchases_big_white"
        case .restaurants: return "restaurants_big_white"
        case .services: return "services_big_white"
        case .travels: return "travels_big_white"
        case .entreteinment: return "entertainment_big_white"
        case .transportation: return "transportation_big_white"
        case .withoutCategory: return "without-category_big_white"
        }
    }
    
    public var smallWhiteImage: UIImage {
        switch self {
        case .groceries: return TransactionsImage(named: "groceries_white")!
        case .healthAndSports: return TransactionsImage(named: "sports_white")!
        case .purchases: return TransactionsImage(named: "purchases_white")!
        case .restaurants: return TransactionsImage(named: "restaurants_white")!
        case .services: return TransactionsImage(named: "services_white")!
        case .travels: return TransactionsImage(named: "travels_white")!
        case .entreteinment: return TransactionsImage(named: "entertainment_white")!
        case .transportation: return TransactionsImage(named: "transportation_white")!
        case .withoutCategory: return TransactionsImage(named: "without-category_white")!
        }
    }
    
    public var image: UIImage {
        switch self {
        case .groceries: return TransactionsImage(named: "groceries")!
        case .healthAndSports: return TransactionsImage(named: "sports")!
        case .purchases: return TransactionsImage(named: "purchases")!
        case .restaurants: return TransactionsImage(named: "restaurants")!
        case .services: return TransactionsImage(named: "services")!
        case .travels: return TransactionsImage(named: "travels")!
        case .entreteinment: return TransactionsImage(named: "entertainment")!
        case .transportation: return TransactionsImage(named: "transportation")!
        case .withoutCategory: return TransactionsImage(named: "without-category")!
        }
    }
    
    public var color: UIColor {
        switch  self {
        case .withoutCategory: return UalaStyle.colors.withoutCategory
        case .entreteinment: return UalaStyle.colors.categoryEntertainment
        case .purchases: return UalaStyle.colors.categoryShopping
        case .healthAndSports: return UalaStyle.colors.categorySport
        case .groceries: return UalaStyle.colors.categorySupermarket
        case .restaurants: return UalaStyle.colors.categoryRestaurant
        case .services: return UalaStyle.colors.categoryPayments
        case .transportation: return UalaStyle.colors.categoryTransport
        case .travels: return UalaStyle.colors.categoryTravel
        }
    }
    
    init(safeRawValue: String) {
        let rawValue = safeRawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        self = TransactionCategory(rawValue: rawValue) ?? .withoutCategory
    }
    
}

public enum TransactionFilter: Int, CaseIterable {
    case showAll = 0
    case showAccountLoads = 1
    case showConsumptions = 2
    case loan = 3
    case showRecharges = 4
    case showAccountWithdrawals = 5
    case showTransferences = 6
    
    public var transactionTypes: [TransactionType] {
        switch self {
        case .showAll: return []
        case .showAccountLoads: return [.cashInDeposit, .cashInTDC, .cashInBankTransfer, .creditAdjustment, .cashOutTDCAdjustment, .adjustment, .processorAdjustment, .paynetClientFeeAdjustment, .atmClientFeeAdjustment, .genericPromoADPA, .ualaAdjustment]
        case .showConsumptions: return [.consumptionPOS, .automaticDebit, .refund, .spending, .reprint, .debitAdjustment]
        case .loan: return [.loanInstallmentPayment, .cashInLoan, .directDebitAdjustment, .loanPayoff]
        case .showRecharges: return [.recharge, .billPayment, .phoneRecharge]
        case .showAccountWithdrawals: return [.cashOutDeposit, .withdrawATM, .withdrawAtmFee, .cashOut, .cashOutTDC]
        case .showTransferences: return [.userToUser, .userToUserReceived, .cashInCVU, .cashOutCVU, .cashInCvuReverse, .cashOutSpei, .cashInSpei]
        }
    }
    
    public var image: UIImage {
        switch self {
        case .showAll: return TransactionsImage(named: "all_black")!
        case .showAccountLoads: return TransactionsImage(named: "income")!
        case .showConsumptions: return TransactionsImage(named: "consumption_filter")!
        case .loan: return TransactionsImage(named: "loan_filter")!
        case .showRecharges: return TransactionsImage(named: "recharge_filter")!
        case .showAccountWithdrawals: return TransactionsImage(named: "withdraw")!
        case .showTransferences: return TransactionsImage(named: "transference")!

        }
    }
    
    public var label: String {
        switch self {
        case .showAll: return translate("SHOW_ALL", from: .Transactions)
        case .showAccountLoads: return translate("SHOW_ACCOUNTLOADS", from: .Transactions)
        case .showConsumptions: return translate("SHOW_CONSUMPTIONS", from: .Transactions)
        case .loan: return translate("SHOW_LOANS", from: .Transactions)
        case .showRecharges: return translate("SHOW_PAYMENTS", from: .Transactions)
        case .showAccountWithdrawals: return translate("SHOW_WITHDRAWALS", from: .Transactions)
        case .showTransferences: return translate("SHOW_TRANSFERENCES", from: .Transactions)
        }
    }
    
    public static var count: Int {
        return TransactionFilter.showTransferences.rawValue + 1
    }
}

public enum TransactionBackEndType: String {
    case consumption = "CONSUMPTION"
    case cashIn = "CASH_IN"
    case transferReceived = "TRANSFER_RECEIVED"
    case transferSent = "TRANSFER_SENT"
    case telerecargas = "TELERECARGA"
}

enum TransactionErrorCode: String {
    case data = "303"
    case amount = "304"
    case minAmount = "305"
    case maxAmount = "306"
    case repeated = "308"
    case provider = "309"
    case invalid = "402"
    case invalidSube = "-101"
    
    var description: String {
        switch self {
        case .data: return translate("DATA_ERROR", from: .Transactions)
        case .amount: return translate("AMOUNT_ERROR", from: .Transactions)
        case .minAmount: return translate("MIN_AMOUNT_ERROR", from: .Transactions)
        case .maxAmount: return translate("MAX_AMOUNT_ERROR", from: .Transactions)
        case .repeated: return translate("REPEATED_ERROR", from: .Transactions)
        case .provider: return translate("PROVIDER_ERROR", from: .Transactions)
        case .invalid: return translate("INVALID_ERROR", from: .Transactions)
        case .invalidSube: return translate("INVALID_SUBE_ERROR", from: .Transactions)
        }
    }
}

public enum AdjustmentCode: String {
    case unknownTransaction = "354"
    case accountDischarge = "650"
    case chargeError = "936"
    case unknownTransaction2 = "456"
    case accountDischarge2 = "651"
    case ualaReward = "849"
    case chargeError2 = "968"
    case bonus = "566"
    case returnCountryTaxLaw30Bis = "539"
    case countryTaxLaw30Bis = "929"
    case countryTaxLaw30 = "540"
    case countryTaxLaw8 = "541"
    case returnCountryTaxLaw30 = "542"
    case returnCountryTaxLaw8 = "543"
    case iibDebit = "548"
    case iibCredit = "549"
    case excesiveCashInCharge = "633"
    case payrollBenefitAdjust = "550"
    case payrollBenefitRecurrent  = "619"
    case cashoutAdjustFee = "572"
    case socialBenefitRecurrent = "663"
    case socialBenefitSingle = "664"
    case hrCampaign = "643"
    case hrInternetCampaign = "642"
    case reverseCashOutRP = "589"
    case reverseFeeCashOutRP = "569"
    case loyaltyReward = "634"
    
    public var text: String? {
        switch self {
        case .unknownTransaction, .unknownTransaction2: return "Desconocimiento de compra/retiro"
        case .accountDischarge, .accountDischarge2: return "Baja de la cuenta"
        case .chargeError, .chargeError2: return "Error en la carga"
        case .ualaReward: return translate("REWARD_TEXT", from: .Transactions)
        case .bonus: return translate("PROMOTION_UALA", from: .Transactions)
        case .countryTaxLaw30, .countryTaxLaw30Bis: return translate("TAX_COUNTRY_30", from: .Transactions)
        case .countryTaxLaw8: return translate("TAX_COUNTRY_8", from: .Transactions)
        case .returnCountryTaxLaw30, .returnCountryTaxLaw30Bis: return translate("TAX_COUNTRY_30_RETURN", from: .Transactions)
        case .returnCountryTaxLaw8: return translate("TAX_COUNTRY_8_RETURN", from: .Transactions)
        case .iibDebit, .iibCredit: return translate("SALARY_TAX", from: .Transactions)
        case .excesiveCashInCharge: return translate("EXCESIVE_CASH_IN_CHARGE", from: .Transactions)
        case .payrollBenefitAdjust, .payrollBenefitRecurrent, .socialBenefitSingle, .socialBenefitRecurrent:
            return translate("TRANSFER_RECEIVED")
        case .cashoutAdjustFee: return translate("ADJUSTMENT_CASHOUT_DETAIL", from: .Transactions)
        case .hrCampaign, .hrInternetCampaign: return translate("UALA_BENEFIT", from: .Transactions)
        case .reverseCashOutRP: return translate("ADJUSTMENT_REVERSE_CASHOUT_TEXT", from: .Transactions)
        case .reverseFeeCashOutRP: return translate("ADJUSTMENT_CASHOUT_TITLE", from: .Transactions)
        case .loyaltyReward: return translate("LOYALTY_REWARD_TEXT", from: .Transactions)
        }
    }
    
    public var title: String? {
        switch self {
        case .excesiveCashInCharge: return translate("EXCESIVE_CASH_IN_CHARGE_TITLE", from: .Transactions)
        case .payrollBenefitAdjust, .payrollBenefitRecurrent : return translate("PAYROLL_BENEFIT", from: .Transactions)
        case .cashoutAdjustFee: return translate("ADJUSTMENT_CASHOUT_TITLE", from: .Transactions)
        case .socialBenefitSingle, .socialBenefitRecurrent: return translate("SOCIAL_BENEFIT", from: .Transactions)
        case .loyaltyReward: return translate("LOYALTY_REWARD_TITLE", from: .Transactions)
        default: return translate("ADJUSTMENT_TITLE", from: .Transactions)
        }
    }
        
    public func detail(credit: Bool) -> String? {
        switch self {
        case .unknownTransaction, .unknownTransaction2: return translate("UNKNOWN_ERROR_DETAIL", from: .Transactions)
        case .accountDischarge, .accountDischarge2: return translate("DISCHARGE_ERROR_DETAIL", from: .Transactions)
        case .chargeError, .chargeError2: return credit ? translate("CHARGE_CREDIT_ERROR_DETAIL", from: .Transactions) : translate("CHARGE_ERROR_DETAIL", from: .Transactions)
        case .ualaReward: return translate("REWARD_DETAIL", from: .Transactions)
        case .bonus: return translate("BONUS_SUBTITLE", from: .Transactions)
        case .countryTaxLaw30, .countryTaxLaw8, .returnCountryTaxLaw8, .returnCountryTaxLaw30, .returnCountryTaxLaw30Bis, .countryTaxLaw30Bis: return translate("ADJUSTMENT_TAX_COUNTRY", from: .Transactions)
        case .iibDebit, .iibCredit: return translate("ADJUSTMENT_SALARY_TAX", from: .Transactions)
        case .excesiveCashInCharge: return translate("EXCESIVE_CASH_IN_CHARGE_DETAIL", from: .Transactions)
        case .reverseCashOutRP: return translate("ADJUSTMENT_REVERSE_CASHOUT_DETAIL", from: .Transactions)
        case .reverseFeeCashOutRP: return translate("ADJUSTMENT_REVERSE_FEE_CASHOUT_DETAIL", from: .Transactions)
        case .payrollBenefitAdjust, .payrollBenefitRecurrent, .cashoutAdjustFee, .socialBenefitSingle,
             .socialBenefitRecurrent, .hrCampaign, .hrInternetCampaign: return nil // Returning nil in order to not create a empty cell.
        case .loyaltyReward: return translate("LOYALTY_REWARD_DETAIL", from: .Transactions)
        }
    }
    
    public var operation: String? {
        switch self {
        case .excesiveCashInCharge: return translate("EXCESIVE_CASH_IN_CHARGE", from: .Transactions)
        case .cashoutAdjustFee: return translate("ADJUSTMENT_CASHOUT_TITLE", from: .Transactions)
        case .payrollBenefitAdjust, .payrollBenefitRecurrent, .socialBenefitSingle, .socialBenefitRecurrent: return translate("TRANSFERENCE", from: .Transactions)
        default: return translate("ADJUSTMENT", from: .Transactions)
        }
    }
    
    public var detailTitle: String? {
        switch self {
        case .excesiveCashInCharge: return translate("EXCESIVE_CASH_IN_CHARGE_TITLE", from: .Transactions)
        case .payrollBenefitAdjust, .payrollBenefitRecurrent : return translate("PAYROLL_BENEFIT", from: .Transactions)
        case .cashoutAdjustFee: return translate("ADJUSTMENT_CASHOUT_TITLE_DETAIL", from: .Transactions)
        case .socialBenefitSingle, .socialBenefitRecurrent: return translate("SOCIAL_BENEFIT", from: .Transactions)
        default: return translate("ADJUSTMENT_TITLE", from: .Transactions)
        }
    }
}

public enum ReconciliationStatus: String {
    case pending = "PENDING"
    case reconcilied = "RECONCILIED"
    
    public init(safeRawValue: String) {
        let rawValue = safeRawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        self = ReconciliationStatus(rawValue: rawValue) ?? .reconcilied
    }
}

public enum TransactionError: String {
    case invalidPin = "denied_auth_invalid_pin"
    case insufficientLimit = "denied_auth_nsf"
    case invalidCard = "denied_auth_invalid_card"
    
    var spending: RejectedCode {
        switch self {
        case .invalidPin:
            return .invalidPin
        case .insufficientLimit:
            return .insuficientLimit
        case .invalidCard:
            return .unsubscribedCard
        }
    }
}
