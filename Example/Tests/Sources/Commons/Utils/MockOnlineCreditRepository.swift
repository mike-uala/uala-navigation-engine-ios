//
//  MockOnlineCreditRepository.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 12/04/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import PromiseKit
@testable import UalaLoans


class MockOnlineCreditRepository: OnlineCreditRepositoryProtocol {
    
    var hasActive: Bool = false
    var hasClosed: Bool = false
    
    init(hasActive: Bool = false, hasClosed: Bool = false) {
        self.hasActive = hasActive
        self.hasClosed = hasClosed
    }
    
    func getOnlineCredits() -> Promise<OnlineCreditInfo?> {
        
        var onlineCredits: [OnlineCredit] = []
        
        let activeOnlineCredit = OnlineCredit(id: "", status: .active, requestStatus: .created, disbursementAmount: 1000, amount: 1000, createdDate: Date(), updatedDate: Date(), amountPaid: 1000, arrearsDue: 0)
        let closedOnlineCredit = OnlineCredit(id: "", status: .closed, requestStatus: .created, disbursementAmount: 1000, amount: 1000, createdDate: Date(), updatedDate: Date(), amountPaid: 1000, arrearsDue: 0)
        
        if hasActive { onlineCredits.append(activeOnlineCredit) }
        if hasClosed { onlineCredits.append(closedOnlineCredit) }
        
        
        return Promise.value(OnlineCreditInfo(summary: InstallmentsSummary(nextRepaymentDate: "10/10/2021", nextRepaymentAmount: "1000"), installments: onlineCredits))
    }
    
    func getOnlineCreditsArrangement() -> Promise<CreditArrangementsService?> {
        
        return Promise.value(CreditArrangementsService(availableBalance: "500", maxAmount: "1000", minAmount: "100"))
    }
    
    func createContract(installmentsBuilder: InstallmentsBuilder) -> Promise<String> {
        
        return Promise.value("")
    }
    
    func downloadOffer(loanId: String) -> Promise<String> {
        return Promise.value("")
    }
}
