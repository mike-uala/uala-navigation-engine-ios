//
//  InstallmentsCreditLimitTest.swift
//  UalaLoans_Tests
//
//  Created by Josefina Perez on 11/05/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import UalaUI
import UalaCore
@testable import UalaLoans


class InstallmentsCreditLimitTest: XCTestCase {
    
           let view: InstallmentsCreditLimitView = InstallmentsCreditLimitView.loadXib()
           let interactor = InstallmentsCreditLimitInteractor()
           let presenter = InstallmentsCreditLimitPresenter()
    
    override func setUp() {
        
        let analytics: Analytics = UalaAnalytics()
        ServiceLocator.sharedLocator.registerSingleton(analytics)
        
        let router = InstallmentsCreditLimitRouter()
        
        let creditArrangements = CreditArrangements(availableBalance: 1200, maxAmount: 3000, minAmount: 100)
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.creditArrangements = creditArrangements
        
        view.creditLimitPresenter = presenter
        interactor.presenter = presenter
        router.viewController = view
    }
    
    func testLabels() {
        
        let expectation = XCTestExpectation()
        
        //act
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
            
            //assert
            XCTAssertEqual(self.view.lblAvailableCreditAmountGraphic.text, "$1.200,00")
            XCTAssertEqual(self.view.lblUsedCreditAmountGraphic.text, "$1.800,00")
            XCTAssertEqual(self.view.lblCreditLimit.text, "Límite de crédito: $3.000,00")
            XCTAssertEqual(self.view.lblAvailableCredit.text, "Crédito disponible: $1.200,00")
            XCTAssertEqual(self.view.lblUsedCredit.text, "Crédito en uso: $1.800,00")
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testChooseTransaction() {
        
        let expectation = XCTestExpectation()
        
        //arrange
        CreditsFlowController.chooseMultipleTransactionsEnabled = true
        let navigationController = MockNavigationController(rootViewController: view)
        
        view.loadViewIfNeeded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            expectation.fulfill()
            
            //act
            self.view.didSelectChooseTransaction()
    
            //assert
            XCTAssertTrue(navigationController.pushedViewController is InstallmentsChooseTransactionView)
        })
        
        wait(for: [expectation], timeout: 5)
    }

}
