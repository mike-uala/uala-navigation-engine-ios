//
//  FeatureFlaggingManager.swift
//  Uala
//
//  Created by Josefina Perez on 17/02/2020.
//  Copyright © 2020 Ualá. All rights reserved.
//

import Foundation
import PromiseKit

public enum Feature: String {

    case installments = "installments"
    case multipleTransactions = "multiple_transactions"
    case cardTravelNotice = "card_travel_notice"
    case ocdeForm = "OCDEForm"
    case investmensOnboardingAB = "investments_onboarding_ab"
    case investmentsContentCard = "investments_content_card"
    case transfersHelp = "transfers_help"
    case cobroExpress = "cash_in_cash_cobro_express"
    case teleRecargas = "cash_in_cash_telerecargas"
    case automaticSuscription = "investments_automatic_subscription"
    case loanStagesPassage = "loan_stages_passage_available"
    case loansWithBenefit = "loan_benefits_available"
    case billPaymentsInstallmentsFeedback = "bill_payment_installments_feedback"
    case loanSimulatorAB = "loan_simulator_ab"
    case loanPS5 = "loan_ps5"
    case loansBenefitEditCbu = "loan_benefits_edit_cbu"
    case installmentsPayOffEnabled = "installments_pay_off"
    case contactExperiment = "contact_experiment"
    case VUOnboarding = "onboarding_sdk_vu"
    case VUDNI = "onboarding_vu_id"
    case processDNIImage = "onboarding_retry_id"
    case onlineCreditFeature = "online_credit_feature_available"
    case isCashOutRapipagoEnabled = "cash-out-rapipago"
    case acquiringAvailabillity = "acquiring_iOS_available"
    case chatStatusEndpointVersion = "new_chat_status_endpoint_version"
    case cashInToken = "cash-in-token"
    case loanOfferAB = "loan_offer_button_ab"
    case helpTreeExperiment = "help_tree_experiment"
    case realTnaSimulation = "real_tna_simulation"
    case virtualCardMexEnabled = "virtual_card_mex_enabled"
    case userLastSessionDate = "user_last_session_date"
    case cashOutFee = "cash_out_rapipago_fee"
    case loansHomeSynchronized = "loans_home_synchronized"
    case usernameAlternative = "username_alternative_mode"
    case cardNumberTransferMex = "card-number-transfer-mex"
    case sendEmailToRecoverAccount = "send_email_to_recover_account"
    case loyalty = "loyalty_program"
    case acquiringMposFeature = "acquiring_ios_mpos_feature"
    case incodeSelfieArg = "sign_up_incode_selfie_ar"
    // MX
    case complianceMXUpdateEmail = "compliance_mx_update_email"
    case complienceMXAccountStatementsMFA = "complience_mx_account_statements_mfa"
    case passwordRulesMx = "password-rules-compliance-mex"
    case changePasswordMx = "change-password-compliance-mex"
    case forgotPasswordMx = "sign-in-change-password-compliance-mex"
    case closeSessionInactivityUser = "close_session_inactivity_user"
    case complianceUserRecognition = "compliance_user_recognition"
}

public protocol SplitRepositoryProtocol {
    func initializeFor(user: String?) -> Promise<Void>
    func finish()
    func getTreatmentFor(_ split: Feature) -> Promise<Bool>
    func getTreatmentFor(_ split: Feature, attributes: [String : Any]?) -> Promise<Bool>
    func getTreatmentsFor(_ split: [Feature]) -> Promise<[Feature: Bool]>
    func getStringTreatmentFor(_ feature: Feature) -> Promise<String?> 
}

public class FeatureFlaggingManager {
    
    public static let shared = FeatureFlaggingManager()
    
    var repository: SplitRepositoryProtocol = SplitRepository.shared
    
    var flags: [Feature: Bool] = [:]
    
    public func getFlagsFor(user: String) -> Promise<Void> {
        
        return Promise<Void> { seal in
            firstly {
                repository.initializeFor(user: user)
            }.then {
                self.getTreatments()
            }.done {
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    public func featureEnabled(_ feature: Feature) -> Bool {
        return flags[feature] ?? false
    }
    
    public func finish() {
        repository.finish()
    }
    
    private var index = 0
    private func getTreatments() -> Promise<Void> {
    
        let features: [Feature] = [.installments, .multipleTransactions, .loanStagesPassage, .loansWithBenefit, .loanSimulatorAB, .loanPS5, .loansBenefitEditCbu, .installmentsPayOffEnabled, .cashInToken, .onlineCreditFeature, .loanOfferAB, .realTnaSimulation, .cashOutFee, .loansHomeSynchronized]
        
        return Promise<Void> { seal in
            
            repository.getTreatmentsFor(features).done { treatments in
                
                self.flags = treatments
                seal.fulfill_()
            }.catch { error in
                seal.reject(error)
            }

        }
    }
}
