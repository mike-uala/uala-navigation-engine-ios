//
//  SecondLoanTutorialTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 21/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaCore
@testable import UalaLoans

class SecondLoanTutorialTest: XCTestCase {
    
    let view: SecondLoanView = SecondLoanView.loadXib()
    let interactor = SecondLoanInteractor()
    let router = SecondLoanRouter()
    var presenter: SecondLoanPresenter!
    var loanHasCbu: Bool = false
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let benefit = Benefit(from: BenefitService(benefitsAvailable: true, benefitType: "LOAN_WITH_BENEFITS", tna: "0.5", maxAmountUser: "100000"))
        
        let loan = MambuLoan(with: MambuLoanData(key: "", id: "BHM666", state: .closed, subState: .unknown, amount: 1000, interestRate: 10, totallyDebt: 700, totallyPaid: 300, totallyDue: 1000, customFields: LoanCustomFields(status: .requestCompleted), product: LoanProduct(iva: 0, originationFee: 0, insuranceFee: 0, daysInMonth: 30, daysInYear: 360), originationAmount: 7, transactions: [], loanValues: LoanValues(payments: 1, paymentAmount: 100, cftWithoutTax: 7, cftWithTax: 10, tna: 3, tea: 4)))
        
        presenter = SecondLoanPresenter(benefit: benefit, loans: [loan])
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        view.secondLoanPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        view.loadViewIfNeeded()
    }
    
    func testTnaAndAmount() {
        
        let expectation = XCTestExpectation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
            
            guard let loanWithBenefitCell =  self.view.tableView.visibleCells.first as? SecondLoanTableViewCell else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(loanWithBenefitCell.lblTitle?.text, "¡Obtené hoy un préstamo\nde hasta $100.000!")
            XCTAssertEqual(loanWithBenefitCell.lblSecondCheck?.text, "Con tasa fija del 50%")
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testAskRegularLoan() {
        
        let expectation = XCTestExpectation()
        let navigationController = MockNavigationController(rootViewController: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
            
            guard let loanCell =  self.view.tableView.visibleCells[1] as? SecondLoanRegularTableViewCell else {
                XCTFail()
                return
            }
            
            loanCell.didSelectButton()
            XCTAssertTrue(navigationController.pushedViewController is LoansOptionsView)
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
}
